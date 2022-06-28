#!/bin/sh -eux

moldMI='
This system was built using the moldMI project by gsebast
(for more information go to https://github.com/gsebast/moldMI)
It is based on the Bento project by Chef Software
(for more information go to https://github.com/chef/bento)
and the Boxcutter repositories
(for more information go to https://github.com/boxcutter)'

if [ -d /etc/update-motd.d ]; then
    MOTD_CONFIG='/etc/update-motd.d/99-moldMI'

    cat >> "$MOTD_CONFIG" <<MOLDMI
#!/bin/sh

cat <<'EOF'
$moldMI
EOF
MOLDMI

    chmod 0755 "$MOTD_CONFIG"
else
    echo "$moldMI" >> /etc/motd
fi
