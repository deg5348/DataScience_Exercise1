# DataScience_Exercise1
    My task in the first exercise will be to define a traffic network with 4 intersections/nodes (1),
    the edges between the nodes must have a length of 150 meters (2). All edges should be
    drivable in both directions, and have 2 lanes per direction (3). Within the
    traffic network, it is not possible to turn. This means that at the intersections it is not possible to turn
    left or right (4).

    The intersections are equipped with traffic lights for traffic control (5). Each edge must turn green once during the phase cycle
    and each phase is followed by a corresponding yellow phase and a red phase of at least 3
    seconds each (6). In total, each traffic light must have a cycle time of 120 seconds (7).

    Further define a traffic demand of a total of 50 vehicles. A vehicle should start every 2 seconds in the simulation (8). The vehicles should
    start alternately at the outer edges of the traffic network in a clockwise direction (9).

    Then enable the simulation of the traffic demand within the traffic network using a
    SUMO config file (10).

    To determine the macroscopic traffic size - average traffic density per edge - continue to create a
    Python script that conducts the simulation (11).
    Use traci within the script to determine the macroscopic traffic size
    - average traffic density per edge - during the simulation (12). Use this Jupyter Notebook and the already prepared next cell for this.

Here I created 4 files which are of structure:
--- Folder Structure ---
.DS_Store
[.git]
    ├── COMMIT_EDITMSG
    ├── FETCH_HEAD
    ├── HEAD
    ├── ORIG_HEAD
    ├── config
    ├── description
    ├── [hooks]
        ├── applypatch-msg.sample
        ├── commit-msg.sample
        ├── fsmonitor-watchman.sample
        ├── post-update.sample
        ├── pre-applypatch.sample
        ├── pre-commit.sample
        ├── pre-merge-commit.sample
        ├── pre-push.sample
        ├── pre-rebase.sample
        ├── pre-receive.sample
        ├── prepare-commit-msg.sample
        ├── push-to-checkout.sample
        ├── sendemail-validate.sample
        └── update.sample
    ├── index
    ├── [info]
        └── exclude
    ├── [logs]
        ├── HEAD
        └── [refs]
            ├── [heads]
                └── master
            └── [remotes]
                └── [origin]
                    └── master
    ├── [objects]
        ├── [00]
            └── 385c32fb0137b25258022332bd05c13024744c
        ├── [02]
            └── b512ca0c1e41f2ca6a67462d5aa8cfcee685c4
        ├── [08]
            └── 7b51633ceebf063b48cacf6fde0516dd8dcbeb
        ├── [0a]
            └── 197900e25d259ab4af2e31e78501787d7a6daa
        ├── [0d]
            └── d0fd7bf81d7512b70a9d7fd973294b768a50f8
        ├── [13]
            └── b77cb2128358d0d13657195dc3dcb6bf83cc09
        ├── [19]
            └── 5e619efcd9a9dd0da59a7b6280cdb2b446fb63
        ├── [1c]
            └── 78dda50e2f397b1c2dd847caf57791e80fcfcb
        ├── [20]
            └── c5d1278bdb99df70d05630290220b15db1617a
        ├── [29]
            └── 0d62a140a255527390cc707e6bc103d46040e3
        ├── [2e]
            └── 71d6f9d47795008cc1e52b5ba0ac5dff65dee7
        ├── [2f]
            └── 6ed9d92bbbac7adf306c242ebc3c6021fe681f
        ├── [32]
            └── 5f92b1add584932f337618295564dd3c0a706a
        ├── [33]
            └── 1f359057dc3a6953af37dbdaadc9243b7fd9b2
        ├── [3a]
            └── 2ab2adac422031b9348036de1cded40b0edb67
        ├── [40]
            └── a0c7e22318bdd50ff50c6588a4a3533d7c1b0c
        ├── [44]
            ├── 600670ec3d5a28ac1cdd0c7428eb320464bb6b
            └── fa29dbbe8d0664257c87bc9fef048868e6a48b
        ├── [4b]
            └── a94c56c4aaf52d3c06b61afb51ebf1f1165d79
        ├── [53]
            └── 9af40a453a7652e390a502f0ec3668d93e20d9
        ├── [5b]
            └── 199b2957b52c578e218d56f104e842fc328dc3
        ├── [60]
            └── 890ba9a1e0e2eac899ed0dbdfa708d50d0a982
        ├── [6d]
            └── e1b794c73503132275c80914d34814432aa269
        ├── [77]
            └── 17452e547b3fafc5a256b3b61de7a1c08bb9a2
        ├── [7e]
            └── b269186527ded596ee49b3875058c13df55a45
        ├── [80]
            └── 498dea04ddec7471181e1785aae940ecbd8fd1
        ├── [82]
            └── cb7e55486e2e0beaa5cdd249a06963674620d0
        ├── [8a]
            └── b9ddb44bad070b9af10e5546b6150899a78d88
        ├── [8e]
            └── 470c793155e4d068477f1ad839048bb6c095d2
        ├── [96]
            └── 7d4dbb50de52ca7e7ec110998bf1735508de4b
        ├── [a9]
            └── 000dea2c87bda104c32de64891f577f778a68c
        ├── [ae]
            └── 5451979d6731dfc9e379421de4f58433339bac
        ├── [c6]
            └── cd1893129326109d4efd3c6bf3c5613e876355
        ├── [c7]
            └── 0fcf90bc59a77bcfc252732450c471c6c8d37f
        ├── [ca]
            └── 2cf3d6ac67f18b81d7417a398acb0ad17168d7
        ├── [ce]
            └── a905c6862e45e3cb821b7efd264709b6962379
        ├── [d0]
            └── 8eab271ac400f4797b012ca89301f0182234b3
        ├── [dc]
            └── 26016134fce790b9b4a3e404d7e8a22df78d7e
        ├── [fc]
            └── 1c3daf06903633d1c10061d69b42886565fe95
        ├── [info]
        └── [pack]
    └── [refs]
        ├── [heads]
            └── master
        ├── [remotes]
            └── [origin]
                └── master
        └── [tags]
.gitignore
Exercise_1.ipynb
README.md
[__pycache__]
    ├── aufg.cpython-311.pyc
    ├── aufg.cpython-313.pyc
    └── aufg.cpython-38.pyc
aufg.py
[docs]
    └── .project_structure_filter
[sumo_conf_files]
    ├── WidthData.txt
    ├── connections.con.xml
    ├── edges.edg.xml
    ├── editednetconfig.netecfg
    ├── netconvert.sh
    ├── network.net.xml
    ├── network.sumocfg
    ├── nodes.nod.xml
    ├── routes.rou.xml
    ├── tls.add.xml
    └── tripinfo.xml

--- File Contents ---
I uploaded the Jupyter Notebook (ipynb) files with the data necessary for our work. After processing, data is transferred to the Netedit design. As a next step, XML files will be created that describe the necessary routes, trips and network information we need to run our service. If you need a explanation or more information please get back to me.





