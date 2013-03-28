#!/bin/bash
echo -e "file_cache_path '${HOME}/.chef/cache'\ncookbook_path '${HOME}/fluxtream-chef/cookbooks'\nchecksum_path '${HOME}/.chef/checksums'" > ~/fluxtream-chef/solo.rb