class memory_monitor ($critical_treshold,$warning_treshold,$email,$relay_user,$relay_path) {

    package { 'vim-enhanced':
        ensure => 'installed',
        name => 'vim-enhanced',
    }
    package { 'curl':
        ensure => 'installed',
        name => 'curl',
    }
    package { 'git':
        ensure => 'installed',
        name => 'git',
    }
    user { 'monitor':
        ensure => 'present',
        shell => '/bin/bash',
        home => '/home/monitor'
    }
    file { '/home/monitor/scripts':
        ensure => 'directory',
    }
    exec { 'retrieve_memory_monitor':
        command => '/usr/bin/wget -q https://raw.githubusercontent.com/cdeocampo/simple-memory-monitor/master/memory_check -O /home/monitor/scripts/memory_check',
        creates => '/home/monitor/scripts/memory_check',
    }
    file { '/home/monitor/scripts/memory_check':
        mode => 0755,
        require => Exec["retrieve_memory_monitor"],
    }
    file { '/home/monitor/src':
        ensure => 'directory',
    }
    file { '/home/monitor/src/my_memory_check':
        ensure => 'link',
        target => '/home/monitor/scripts/memory_check',
    }
    file { '/etc/environment':
        content =>  "RELAY_USER='$relay_user'\nRELAY_PATH='$relay_path'",
    }
    cron { 'memory_check_cron':
        command => "/home/monitor/src/my_memory_check -c $critical_treshold -w $warning_treshold -e \"$email\"",
        user => 'root',
        minute => '*/10',
    }
}