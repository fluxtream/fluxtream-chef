branch = node["branch"]

git "clone fluxtream-app repo" do
	repository "git://github.com/fluxtream/fluxtream-app"
	depth 3
	destination "/home/fluxtream/projects/fluxtream-app"
	user "fluxtream"
	group "users"
	action :sync
end

execute "copy sample properties" do
  command "cp /home/fluxtream/projects/fluxtream-app/fluxtream-web/src/main/resources/samples/* /home/fluxtream/projects/fluxtream-app/fluxtream-web/src/main/resources"
  user "fluxtream"
end