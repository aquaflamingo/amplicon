class Repository < ApplicationRecord
  # The type of repository
  enum resource: [:protocol]

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true, length: { minimum: 0, maximum: 140 }
  validates :resource, presence: true, inclusion: resources.keys

  after_create :initialize_repository

  def content
    @content ||= Git.bare(
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
    git_repo = Git.clone(path, bare: true)
  end

  def init_local(path)
    git_repo = Git.init(path)

    begin 
    FileUtils.mkdir_p(
      [
      File.join(local_disk_path, "methods"), 
      File.join(local_disk_path, "reagents"),
      File.join(local_disk_path, "equipment")
      ]
    )

    path = File.join(local_disk_path, "README.md")
    File.open(path, "w") { |f| f.puts "# #{name}" }

    git_repo.add(all: true)
    git_repo.commit("Initialize repository")
    rescue Exception => e
      Rails.logger.error("Failed to initiatize repository #{e.message}")

      FileUtils.rm_rf(local_disk_path)
    end
  end
end
