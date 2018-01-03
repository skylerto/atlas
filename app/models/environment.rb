class Environment < ApplicationRecord
  has_and_belongs_to_many :versions

  ##
  # Bump the environments version of a service. This method is to be called from
  # the Deployment class when a deployment is executed.
  #
  # @param [Service] service
  # @param [Version] version
  def bump_version(service, version)
    current = version? service
    raise "Service #{service.name} doesn't exist on this Environment #{self.name}" if current.nil?
    self.versions.delete current
    self.versions << version
    self.save
  end

  ##
  # Determine the environments Version of the service.
  #
  # @param [Service] service
  # @returns [Version]
  def version?(service)
    versions = self.versions.select { |v| v.service.eql?(service) }
    return nil if versions.empty?
    versions.first
  end
end
