class Repository < ApplicationRecord
  # The type of repository
  enum resource: [:protocol]

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true, length: { minimum: 0, maximum: 140 }
  validates :resource, presence: true, inclusion: resources.keys

  after_create :initialize_repository

  def user
    "user"
  end

  def g
    @g ||= Git.open(
      local_disk_path
    )
  end

  private 
  def initialize_repository
    init_local(local_disk_path)
    upload_bare_remote(local_disk_path)
  end

  def local_disk_path
    Rails.root.join("tmp/git/user/#{name}")
  end

  def upload_bare_remote(path)
    bare_path = path.to_s << ".git"
    git_repo = Git.clone(path, bare_path, bare: true)
    # upload here
  end

  def init_local(path)
    git_repo = Git.init(path.to_s)

    begin 
      File.open(File.join(path, "methods.md"), "w") { |f| f.puts "# Methods" }
      File.open(File.join(path, "reagents.md"),"w") { |f| f.puts "# Reagents" }
      File.open(File.join(path, "equipment.md"), "w") { |f| f.puts "# Equipment" }
      File.open(File.join(path, "README.md"), "w") { |f| f.puts "# #{name}" }

    git_repo.add(all: true)
    git_repo.commit("Initialize repository")
    rescue Exception => e
      Rails.logger.error("Failed to initiatize repository #{e.message}")

      FileUtils.rm_rf(path)
    end
  end
end
