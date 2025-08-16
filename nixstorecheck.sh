for i in `ls /nix/store | grep "cue"`
    do
        nix-store -q --referrers-closure /nix/store/"$i"
    done
