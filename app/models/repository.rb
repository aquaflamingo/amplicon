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
    g = Git.init(
      local_disk_path,
      bare: true
    )

    make_protocol_starter(g)
  end

  def local_disk_path
    Rails.root.join("tmp/git/user/#{name}.git")
  end

  def make_protocol_starter(git_repo)
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

      binding.pry
      # TODO cannot add and commit to bare repo
    git_repo.add(all: true)
    git_repo.commit("Initialize repository")
      binding.pry
    rescue Exception => e
      Rails.logger.error("Failed to initiatize repository #{e.message}")

      FileUtils.rm_rf(local_disk_path)
    end
  end
end
