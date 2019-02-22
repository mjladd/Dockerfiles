# jenkins_dockerfile_spec.rb

require "serverspec"
require "docker"

describe "Dockerfile" do
  image = Docker::Image.build_from_dir('.')

  set :os, family: :redhat
  set :backend, :docker
  set :docker_image, image.id

  describe file('/etc/centos-release' )do
    it { should be_file }
  end

  describe package('jenkins') do
      it { should be_installed }
  end

end





