require "fileutils"

ruby_block "set-environment" do
  block do
    file = Chef::Util::FileEdit.new("/etc/environment")
    file.insert_line_if_no_match(
      "TARGET_ENV=\"local\"",
      "TARGET_ENV=\"local\""
    )
    file.insert_line_if_no_match(
      "JAVA_HOME=\"/usr/lib/jvm/jdk1\.7\.0_17\"",
      "JAVA_HOME=\"/usr/lib/jvm/jdk1.7.0_17\""
    )
    file.write_file
  end
end

directory "/usr/share/tomcat/webapps" do
	recursive true
	action :delete
end

directory "/usr/share/tomcat/webapps" do
	user "tomcat"
	group "tomcat"
	mode 00755
	action :create
end

link "/usr/share/tomcat/webapps/ROOT" do
	to "/home/work/fluxtream-app/fluxtream-web/target/ROOT"
	link_type :symbolic
end