#!/bin/bash

# Fixed SUMO network build script
# This script creates all necessary files and builds the network correctly
# Network: 4 junctions with 4 traffic lights and 8 external nodes (4*2)

echo "Creating SUMO network files with 4 traffic light junctions..."

# Create nodes.nod.xml - 4 junctions + 8 external nodes
cat > nodes.nod.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<nodes version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://sumo.dlr.de/xsd/nodes_file.xsd">
    <!-- 4 Traffic Light Junctions (2x2 grid) -->
    <node id="J1" x="0.0" y="100.0" type="traffic_light"/>
    <node id="J2" x="100.0" y="100.0" type="traffic_light"/>
    <node id="J3" x="0.0" y="0.0" type="traffic_light"/>
    <node id="J4" x="100.0" y="0.0" type="traffic_light"/>
    
    <!-- 8 External nodes (2 per junction) -->
    <!-- J1 external nodes -->
    <node id="N1" x="-50.0" y="100.0" type="priority"/>
    <node id="N2" x="0.0" y="150.0" type="priority"/>
    
    <!-- J2 external nodes -->
    <node id="N3" x="150.0" y="100.0" type="priority"/>
    <node id="N4" x="100.0" y="150.0" type="priority"/>
    
    <!-- J3 external nodes -->
    <node id="N5" x="-50.0" y="0.0" type="priority"/>
    <node id="N6" x="0.0" y="-50.0" type="priority"/>
    
    <!-- J4 external nodes -->
    <node id="N7" x="150.0" y="0.0" type="priority"/>
    <node id="N8" x="100.0" y="-50.0" type="priority"/>
</nodes>
EOF

# Create edges.edg.xml - Bidirectional edges for 4 junctions
cat > edges.edg.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<edges version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://sumo.dlr.de/xsd/edges_file.xsd">
    <!-- Horizontal edges connecting junctions -->
    <edge id="E1_2" from="J1" to="J2" priority="2" numLanes="1" speed="13.89"/>
    <edge id="E2_1" from="J2" to="J1" priority="2" numLanes="1" speed="13.89"/>
    <edge id="E3_4" from="J3" to="J4" priority="2" numLanes="1" speed="13.89"/>
    <edge id="E4_3" from="J4" to="J3" priority="2" numLanes="1" speed="13.89"/>
    
    <!-- Vertical edges connecting junctions -->
    <edge id="E1_3" from="J1" to="J3" priority="2" numLanes="1" speed="13.89"/>
    <edge id="E3_1" from="J3" to="J1" priority="2" numLanes="1" speed="13.89"/>
    <edge id="E2_4" from="J2" to="J4" priority="2" numLanes="1" speed="13.89"/>
    <edge id="E4_2" from="J4" to="J2" priority="2" numLanes="1" speed="13.89"/>
    
    <!-- External connections (2 per junction) -->
    <!-- J1 connections -->
    <edge id="EN1_J1" from="N1" to="J1" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EJ1_N1" from="J1" to="N1" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EN2_J1" from="N2" to="J1" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EJ1_N2" from="J1" to="N2" priority="1" numLanes="1" speed="13.89"/>
    
    <!-- J2 connections -->
    <edge id="EN3_J2" from="N3" to="J2" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EJ2_N3" from="J2" to="N3" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EN4_J2" from="N4" to="J2" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EJ2_N4" from="J2" to="N4" priority="1" numLanes="1" speed="13.89"/>
    
    <!-- J3 connections -->
    <edge id="EN5_J3" from="N5" to="J3" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EJ3_N5" from="J3" to="N5" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EN6_J3" from="N6" to="J3" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EJ3_N6" from="J3" to="N6" priority="1" numLanes="1" speed="13.89"/>
    
    <!-- J4 connections -->
    <edge id="EN7_J4" from="N7" to="J4" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EJ4_N7" from="J4" to="N7" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EN8_J4" from="N8" to="J4" priority="1" numLanes="1" speed="13.89"/>
    <edge id="EJ4_N8" from="J4" to="N8" priority="1" numLanes="1" speed="13.89"/>
</edges>
EOF

# Create simplified connections.con.xml (straight movements only)
cat > connections.con.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<connections version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://sumo.dlr.de/xsd/connections_file.xsd">
    <!-- Only allow straight-through movements at each junction -->
    
    <!-- Junction J1 (top-left) -->
    <connection from="EN1_J1" to="E1_2" fromLane="0" toLane="0"/>
    <connection from="E2_1" to="EJ1_N1" fromLane="0" toLane="0"/>
    <connection from="EN2_J1" to="E1_3" fromLane="0" toLane="0"/>
    <connection from="E3_1" to="EJ1_N2" fromLane="0" toLane="0"/>
    
    <!-- Junction J2 (top-right) -->
    <connection from="E1_2" to="EJ2_N3" fromLane="0" toLane="0"/>
    <connection from="EN3_J2" to="E2_1" fromLane="0" toLane="0"/>
    <connection from="EN4_J2" to="E2_4" fromLane="0" toLane="0"/>
    <connection from="E4_2" to="EJ2_N4" fromLane="0" toLane="0"/>
    
    <!-- Junction J3 (bottom-left) -->
    <connection from="EN5_J3" to="E3_4" fromLane="0" toLane="0"/>
    <connection from="E4_3" to="EJ3_N5" fromLane="0" toLane="0"/>
    <connection from="EN6_J3" to="E3_1" fromLane="0" toLane="0"/>
    <connection from="E1_3" to="EJ3_N6" fromLane="0" toLane="0"/>
    
    <!-- Junction J4 (bottom-right) -->
    <connection from="E3_4" to="EJ4_N7" fromLane="0" toLane="0"/>
    <connection from="EN7_J4" to="E4_3" fromLane="0" toLane="0"/>
    <connection from="EN8_J4" to="E4_2" fromLane="0" toLane="0"/>
    <connection from="E2_4" to="EJ4_N8" fromLane="0" toLane="0"/>
</connections>
EOF

# Create routes.rou.xml with vehicle flows
cat > routes.rou.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<routes xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://sumo.dlr.de/xsd/routes_file.xsd">
    
    <!-- Enhanced vehicle types for different traffic patterns -->
    <vType id="car" accel="2.6" decel="4.5" sigma="0.5" length="5.0" maxSpeed="50.0"/>
    <vType id="slow_car" accel="1.8" decel="3.5" sigma="0.8" length="5.5" maxSpeed="35.0"/>
    <vType id="truck" accel="1.2" decel="3.0" sigma="0.3" length="12.0" maxSpeed="40.0"/>
    <vType id="bus" accel="1.0" decel="2.8" sigma="0.4" length="15.0" maxSpeed="45.0"/>
    
    <!-- Original straight movement routes -->
    <route id="horizontal_top" edges="EN1_J1 E1_2 EJ2_N3"/>
    <route id="horizontal_top_reverse" edges="EN3_J2 E2_1 EJ1_N1"/>
    <route id="horizontal_bottom" edges="EN5_J3 E3_4 EJ4_N7"/>
    <route id="horizontal_bottom_reverse" edges="EN7_J4 E4_3 EJ3_N5"/>
    
    <route id="vertical_left" edges="EN2_J1 E1_3 EJ3_N6"/>
    <route id="vertical_left_reverse" edges="EN6_J3 E3_1 EJ1_N2"/>
    <route id="vertical_right" edges="EN4_J2 E2_4 EJ4_N8"/>
    <route id="vertical_right_reverse" edges="EN8_J4 E4_2 EJ2_N4"/>
    
    <!-- Additional routes using existing valid connections -->
    <!-- These routes create more traffic on the same paths as your originals -->
    <route id="extra_horizontal_top" edges="EN1_J1 E1_2 EJ2_N3"/>
    <route id="extra_horizontal_top_reverse" edges="EN3_J2 E2_1 EJ1_N1"/>
    <route id="extra_vertical_left" edges="EN2_J1 E1_3 EJ3_N6"/>
    <route id="extra_vertical_right" edges="EN4_J2 E2_4 EJ4_N8"/>
    
    <!-- TRAFFIC FLOWS - KEEPING UNDER 50 VEHICLES PER HOUR -->
    <!-- Horizontal flows - reduced to max 50 veh/hr -->
    <flow id="flow_h_top" route="horizontal_top" begin="0" end="3600" vehsPerHour="50" type="car"/>
    <flow id="flow_h_top_rev" route="horizontal_top_reverse" begin="15" end="3600" vehsPerHour="45" type="car"/>
    <flow id="flow_h_bottom" route="horizontal_bottom" begin="30" end="3600" vehsPerHour="50" type="car"/>
    <flow id="flow_h_bottom_rev" route="horizontal_bottom_reverse" begin="45" end="3600" vehsPerHour="45" type="car"/>
    
    <!-- Vertical flows - reduced to max 50 veh/hr -->
    <flow id="flow_v_left" route="vertical_left" begin="60" end="3600" vehsPerHour="50" type="car"/>
    <flow id="flow_v_left_rev" route="vertical_left_reverse" begin="75" end="3600" vehsPerHour="45" type="car"/>
    <flow id="flow_v_right" route="vertical_right" begin="90" end="3600" vehsPerHour="50" type="car"/>
    <flow id="flow_v_right_rev" route="vertical_right_reverse" begin="105" end="3600" vehsPerHour="45" type="car"/>
    
    <!-- Additional flows using the same valid routes - ALL UNDER 50 veh/hr -->
    <flow id="flow_extra_h_top" route="extra_horizontal_top" begin="300" end="3600" vehsPerHour="40" type="slow_car"/>
    <flow id="flow_extra_h_top_rev" route="extra_horizontal_top_reverse" begin="315" end="3600" vehsPerHour="35" type="car"/>
    <flow id="flow_extra_v_left" route="extra_vertical_left" begin="330" end="3600" vehsPerHour="40" type="car"/>
    <flow id="flow_extra_v_right" route="extra_vertical_right" begin="345" end="3600" vehsPerHour="40" type="slow_car"/>
    
    <!-- Mixed vehicle type flows - ALL UNDER 50 veh/hr -->
    <flow id="truck_flow_h1" route="horizontal_top" begin="240" end="3600" vehsPerHour="15" type="truck"/>
    <flow id="truck_flow_h2" route="horizontal_bottom_reverse" begin="255" end="3600" vehsPerHour="15" type="truck"/>
    <flow id="bus_flow_v1" route="vertical_left" begin="270" end="3600" vehsPerHour="8" type="bus"/>
    <flow id="bus_flow_v2" route="vertical_right_reverse" begin="285" end="3600" vehsPerHour="8" type="bus"/>
    
    <!-- Peak hour additional flows - ALL UNDER 50 veh/hr -->
    <flow id="peak_flow_1" route="horizontal_top" begin="1800" end="2700" vehsPerHour="30" type="car"/>
    <flow id="peak_flow_2" route="vertical_left_reverse" begin="1800" end="2700" vehsPerHour="25" type="car"/>
    <flow id="peak_flow_3" route="horizontal_bottom_reverse" begin="1800" end="2700" vehsPerHour="30" type="car"/>
    
</routes>
EOF

# Create configuration file (without TLS file to avoid errors)
cat > network.sumocfg << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<configuration xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://sumo.dlr.de/xsd/sumoConfiguration.xsd">
    <input>
        <net-file value="network.net.xml"/>
        <route-files value="routes.rou.xml"/>
    </input>
    <time>
        <begin value="0"/>
        <end value="3600"/>
        <step-length value="0.1"/>
    </time>
    <processing>
        <collision.action value="warn"/>
        <collision.check-junctions value="true"/>
    </processing>
    <report>
        <verbose value="true"/>
        <no-step-log value="false"/>
    </report>
</configuration>
EOF

echo "All input files created successfully!"
echo ""

# Build the network
echo "Building SUMO network with 4 traffic light junctions..."
netconvert \
    --node-files=nodes.nod.xml \
    --edge-files=edges.edg.xml \
    --connection-files=connections.con.xml \
    --output-file=network.net.xml \
    --no-turnarounds=true \
    --verbose

# Check if network was created successfully
if [ -f "network.net.xml" ]; then
    echo ""
    echo "✅ Network generation successful!"
    echo ""
    echo "Files created:"
    echo "  📄 nodes.nod.xml"
    echo "  📄 edges.edg.xml" 
    echo "  📄 connections.con.xml"
    echo "  📄 routes.rou.xml"
    echo "  📄 network.sumocfg"
    echo "  🌐 network.net.xml"
    echo ""
    echo "To run simulation:"
    echo "  📟 Command line: sumo -c network.sumocfg"
    echo "  🖥️  GUI: sumo-gui -c network.sumocfg"
    echo ""
    echo "Network features:"
    echo "  ✓ 4 traffic light junctions (J1, J2, J3, J4)"
    echo "  ✓ 8 external nodes (2 per junction: N1-N8)"
    echo "  ✓ Only straight-through traffic movements"
    echo "  ✓ No turning movements (as requested)"
    echo "  ✓ Bidirectional traffic flows"
    echo "  ✓ 2x2 grid layout"
    echo ""
    echo "Layout:"
    echo "    N2    N4"
    echo "    |     |"
    echo "N1-[J1]=[J2]-N3"
    echo "    |     |"
    echo "N5-[J3]=[J4]-N7"
    echo "    |     |"
    echo "    N6    N8"
else
    echo ""
    echo "❌ Network generation failed!"
    echo "Please check SUMO installation and error messages above."
    echo ""
    echo "Common issues:"
    echo "  - SUMO not installed or not in PATH"
    echo "  - Input file format errors"
    echo "  - Missing dependencies"
    echo ""
    echo "Try running: which netconvert"
    echo "If not found, install SUMO: https://eclipse.dev/sumo/"
fi