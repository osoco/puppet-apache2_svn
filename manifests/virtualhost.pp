define apache2_svn::virtualhost($virtualhost_name, $server_admin_mail, $document_root = "",
                                $svn_location, $svn_parent_path, 
                                $auth_name, $auth_file, $access_file, $allowed_hosts = [],
                                $is_https = false, $ssl_cert = "", $ssl_cert_key = "", $rewrite_conds = [],
                                $virtualhost_specifics = "") {
    include apache2_svn

    notify { "Apache2-Svn: Creating virtualhost $virtualhost_name with the conf: DocumentRoot '$document_root', IsHttps '$is_https', rewrite_conds '$rewrite_conds'": }

    apache2::virtualhost { "$virtualhost_name":
        virtualhost_name => "$virtualhost_name",
        server_admin_mail => "$server_admin_mail",
        document_root => "$document_root",
        virtualhost_specifics => template("apache2_svn/svn_virtual_host_specifics.erb"),
        is_https => $is_https,
        ssl_cert => "$ssl_cert",
        ssl_cert_key => "$ssl_cert_key",
        rewrite_conds => $rewrite_conds,
    }
}
