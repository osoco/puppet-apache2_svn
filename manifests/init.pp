class apache2_svn ($version = "latest") {

    include svn
    include apache2

    package { libapache2-svn:
        ensure => $version
    }

    include apache2::auth_digest

    $module_suffix = "apache2-svn"

    apache2::module { "dav_svn-$module_suffix":
        modname => "dav_svn",
    }

}
