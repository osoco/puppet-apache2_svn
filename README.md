puppet-apache2_svn
==================

Puppet module to manage a typical svn apache2 configuration. 
Depends on 
  * https://github.com/osoco/puppet-apache2
  * https://github.com/osoco/puppet-apache2_ssl (not mandatory, but usefull for ssl repos)

Example using both apache2 and apache2_ssl modules:

    class my_svn_apache2_class {

        $svn_host_name = 'svn.myorg.com'
        $svn_home = '/var/svn'

        apache2_ssl::certificate { "$svn_host_name-cert":
            cert_name => "$svn_host_name",
            cert_file_source => "puppet:///modules/my_svn_apache2_class/$svn_host_name.pem",
            cert_key_file_source => "puppet:///modules/my_svn_apache2_class/$svn_host_name.key"
        }

        include apache2_ssl

        apache2_svn::virtualhost { "$svn_host_name":
           virtualhost_name => "$svn_host_name",
           server_admin_mail => 'admin@myorg.com',
           document_root => "$svn_home",
           svn_location => '/subversion',
           svn_parent_path => "$svn_home",
           auth_file => "$svn_home/conf/svn-auth",
           access_file => "$svn_home/conf/svn-access",
           auth_name => "MyOrg SVN Repo",
           ssl_cert => "$apache2_ssl::apache2_ssl_dir/$svn_host_name.pem",
           ssl_cert_key => "$apache2_ssl::apache2_ssl_dir/$svn_host_name.key",
           is_https => true,
           rewrite_conds => ['RewriteCond $0 !(^/ssl_not_needed_location/)']
       }
    }





