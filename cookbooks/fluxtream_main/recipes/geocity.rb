remote_file "/home/fluxtream/projects/fluxtream-app/GeoLiteCity.dat.gz"  do
	source "http://fluxtream.org/GeoLiteCity.dat.gz"
	owner "fluxtream"
	group "users"
	action :create_if_missing
end

execute "unzip geoLiteCity" do
	user "fluxtream"
	cwd "/home/fluxtream/projects/fluxtream-app"
	command "gunzip GeoLiteCity.dat.gz"
end

file "/home/fluxtream/projects/fluxtream-app/GeoLiteCity.dat" do
	group "users"
	mode 00644
end