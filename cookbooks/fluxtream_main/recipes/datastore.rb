git "clone datastore" do
	repository "git://github.com/BodyTrack/datastore.git"
	destination "/home/fluxtream/projects/datastore"
	user "fluxtream"
	action :sync
end

execute "make datastore" do
	cwd "/home/fluxtream/projects/datastore"
	user "fluxtream"
	command "make"
end

directory "/home/fluxtream/db" do
  owner "tomcat"
  group "tomcat"
  mode 00755
  action :create
end

directory "/home/fluxtream/db/dev.kvs" do
  owner "tomcat"
  group "tomcat"
  mode 00755
  action :create
end
