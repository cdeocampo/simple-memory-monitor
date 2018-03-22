class memory_monitor {
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
        ensure => 'directory'
    }
}