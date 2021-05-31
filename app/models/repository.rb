class Repository < ApplicationRecord
  # The type of repository
  enum resource: [:protocol]

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :description, presence: true, length: { minimum: 0, maximum: 140 }
  validates :resource, presence: true, inclusion: resources.keys

  after_create :initialize_bare_repository

  private 
  def initialize_repository
    g = Git.init(
      local_disk_path,
      bare: true
    )

    make_protocol_starter(g)
  end

  def local_disk_path
    "/var/git/user/#{name}.git"
  end

  def make_protocol_starter(git_repo)
    FileUtils.mkdir(
      File.join(local_disk_path, "methods"), 
      File.join(local_disk_path, "reagents"),
      File.join(local_disk_path, "equipment")
    )

    FileUtils.touch(File.join(local_disk_path), "README.md")

    git_repo.add(all: true)
    git_repo.commit("Initialize repository")
  end
end
