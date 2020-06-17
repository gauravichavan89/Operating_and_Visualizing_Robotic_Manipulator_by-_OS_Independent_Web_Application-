# Operating_and_Visualizing_Robotic_Manipulator_by-_OS_Independent_Web_Application-

We have proposed a system that computes the orientation and position of each of the 6 joints of our robotic manipulator -’Aubo i5’, wired to the server’s system while it picks up and drops an object using Inverse Kinematics. This data is then communicated to the client’s side for visualizing it in a 3D web application through TCP connection.


In this project, we control a robotic arm via web interface, and visualise it in browser. For the
demo, we divide it in three parts, robot control mechanism, socket connection over local
network, and web visualisation. We show each of the steps separately, which would work if it is
integrated with real robot.


1. For robot arm mechanism, we have provided two scripts of matlab. One for forward
kinematics, one for inverse kinematics. Put six positive angles in forward
kinematics(forward_kinematics.m), which will result a 4*4matrics, in this format, where
px, py px is the final position and first 3*3 matrix is rotation. Put these values on the
inverse kinematics(inverse_kinematics_positive_roots_only.m), where the output are
angles. If the angles are same as forward kinematics, it indicates the calculation is right.

  [ mx nx ox px;
    my ny oy py;
    mz nz oz pz;
    0 0 0 1]
    
We have included inverse_kinematics_positive_negative_roots.py for both positive
and negative roots and although we aren't using this we have included this as it
includes both positive and negative roots and it would be used in future to fix the
existing drawback of handling orientation values with negative roots.



2. For checking the communication part between the ROS and client server, install ROS
kinetic in a ubuntu computer. ( http://wiki.ros.org/kinetic/Installation/Ubuntu ) 
Install Rosbridge by the command “sudo apt-get install ros-kinetic-rosbridge-suite”. 


Setup the bash file by the command “source /opt/ros/kinetic/setup.bash”. Add the ipv4 id of Linux
in the .bashrc file in home. In client side, replace that ipv4 id in the Rosbridge.js, line 12,
keeping 9090 port number same. Use a local network for the connection, and make sure
there is no firewall restriction for input connection via local network in Ubuntu OS. 


After that, in terminal of Ubuntu, write command “roscore” for launching ROS. For publishing
data from Ros to cross platform client, open another terminal and write “rostopic pub
/listener std_msgs/String "Hello, World"” (This message is used as the incoming
information from the server side to client side, which will be the information of the angles
calculated by the Inverse kinematics in server and will be used to animate the client side
mesh). Launch ros-bridge by the command “roslaunch rosbridge_server
rosbridge_websocket.launch”. On the client side, ros.html page. If everything is done
properly, on the console of the browser, it will show 'Connected to websocket server.'
message in the terminal of Ubuntu, it will show connected client. 


After this, you can send object information from the web page to server by clicking Send Position button.


3. In the web visualization part, the colored object represents the real object in a scene. The
represented skeleton is in the scale of cm. You can control the object position with button and
see it in the input box, as well as you can directly control the object putting values in the input
field and clicking poseupdate button. The rotation matrices (same as described in point1) can
be checked in the console of the browser, which will be sent to the server. Ideally, the arm
would animate when it gets angle values from the server, but for the demo, you can put angles
in the 6 joint values and click animate button to check the animation effect. For the performance graph,
click on the color panel on top left on the screen. For manipulation of scene, use left mouse to
rotate scene, scroll to zoom in or zoom out etc.

