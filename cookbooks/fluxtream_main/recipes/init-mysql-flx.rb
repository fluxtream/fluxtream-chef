mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

mysql_database 'flx' do
  connection mysql_connection_info
  action :create
end

mysql_database_user 'flx' do
  connection mysql_connection_info
  password 'fluxtream'
  database_name 'flx'
  host '%'
  privileges [:all]
  action :grant
end

execute "execute ddl script" do
  command "mysql -u root -pfluxtream flx <schema-after-0.9.0010.sql"
  cwd "/home/fluxtream/projects/fluxtream-app/fluxtream-web/db/0.9.0010"
  user "fluxtream"
  action :run
end

execute "import cities1000" do
  command "mysql -u root -pfluxtream flx <cities1000.sql"
  cwd "/home/fluxtream/projects/fluxtream-app"
  user "fluxtream"
  action :run
end
