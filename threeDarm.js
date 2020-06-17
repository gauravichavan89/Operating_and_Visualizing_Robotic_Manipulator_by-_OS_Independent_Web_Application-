var scene3d = document.getElementById("scene3D");
document.getElementById("x+").addEventListener("click",xTranlateRight);
 document.getElementById("x-").addEventListener("click",xTranlateLeft);
 document.getElementById("y+").addEventListener("click",yTranlateUp);
 document.getElementById("y-").addEventListener("click",yTranlateDown);
 document.getElementById("z+").addEventListener("click",zTranlateRight);
document.getElementById("z-").addEventListener("click",zTranlateLeft);
document.getElementById("updatePose").addEventListener("click",updatePose);

var inputX = document.getElementById("inputX");
var inputY = document.getElementById("inputY");
var inputz = document.getElementById("inputZ");
var inputXrotation = document.getElementById("inputXrotation");
var inputYrotation = document.getElementById("inputYrotation");
var inputZrotation = document.getElementById("inputZrotation");


/**
* Generate a scene object with a background color
**/

function getScene() {
    var scene = new THREE.Scene();
    scene.background = new THREE.Color(0x111111);
    return scene;
}
AxisObjects = [];
/**
* Generate the camera to be used in the scene. Camera args:
*   [0] field of view: identifies the portion of the scene
*     visible at any time (in degrees)
*   [1] aspect ratio: identifies the aspect ratio of the
*     scene in width/height
*   [2] near clipping plane: objects closer than the near
*     clipping plane are culled from the scene
*   [3] far clipping plane: objects farther than the far
*     clipping plane are culled from the scene
**/

function getCamera() {
    var aspectRatio = 300 / 300;
    var camera = new THREE.PerspectiveCamera(75, aspectRatio, 0.1, 1000);
    camera.position.set(0, 50, 200);
    return camera;
}

/**
* Generate the light to be used in the scene. Light args:
*   [0]: Hexadecimal color of the light
*   [1]: Numeric value of the light's strength/intensity
*   [2]: The distance from the light where the intensity is 0
* @param {obj} scene: the current scene object
**/

function getLight(scene) {
    var light = new THREE.PointLight(0xffffff, 1, 0);
    light.position.set(200, 200, 200);
    scene.add(light);
    var light2 = new THREE.PointLight(0xffffff, 1, 0);
    light2.position.set(-200, -200, -200);
    scene.add(light2);

    var ambientLight = new THREE.AmbientLight(0x111111);
    scene.add(ambientLight);
    return light;
}

/**
* Generate the renderer to be used in the scene
**/

function getRenderer() {
    // Create the canvas with a renderer
    var renderer = new THREE.WebGLRenderer({ antialias: true });
    // Add support for retina displays
    renderer.setPixelRatio(window.devicePixelRatio);
    // Specify the size of the canvas
    renderer.setSize(window.innerWidth, window.innerHeight);
    // Add the canvas to the DOM
    document.body.appendChild(renderer.domElement);
    return renderer;
}

/**
* Generate the controls to be used in the scene
* @param {obj} camera: the three.js camera for the scene
* @param {obj} renderer: the three.js renderer for the scene
**/

function getControls(camera, renderer) {
    var controls = new THREE.TrackballControls(camera, renderer.domElement);
    controls.zoomSpeed = 0.4;
    controls.panSpeed = 0.4;
    return controls;
}
function gridCreate() {
    var size = 100;
    var divisions = 20;

    var gridHelper = new THREE.GridHelper(size, divisions);
    scene.add(gridHelper);
}
/**
* Load Nimrud model
**/

function loadModel(fileLocation, x, y, z, rx, ry, rz) {
    var loader = new THREE.OBJLoader();
    loader.load(fileLocation, function (object) {
        object.rotation.z = Math.PI;
        object.position.x = x;
        object.position.y = y;
        object.position.z = z;
        object.rotateX(THREE.Math.degToRad(rx));
        object.rotateY(THREE.Math.degToRad(ry));
        object.rotateZ(THREE.Math.degToRad(rz));
        //object.scale.set(0.1, 0.1, 0.1);
        scene.add(object);
        // document.querySelector('h1').style.display = 'none';
    });
}

/**
* Render!
**/

function render() {
    requestAnimationFrame(render);
    scene3d.appendChild(renderer.domElement);
    renderer.render(scene, camera);
    renderer.setSize(350, 350);
    controls.update();
    gridCreate();
};

var scene = getScene();
var camera = getCamera();
var light = getLight(scene);
var renderer = getRenderer();
var controls = getControls(camera, renderer);

var xAxis, material, radius;
var objGeometry = new THREE.BoxGeometry(15, 2, 2);
material = new THREE.MeshPhongMaterial({ color: "rgb(255,0,0)"});
material.transparent = true;
xAxis = new THREE.Mesh(objGeometry, material);
yAxis = new THREE.Mesh(new THREE.BoxGeometry(2, 15, 2), new THREE.MeshPhongMaterial({ color: "rgb(0,255,0)"}));
zAxis = new THREE.Mesh(new THREE.BoxGeometry(2, 2, 15), new THREE.MeshPhongMaterial({ color: "rgb(0,0,255)"}));

function createCube(scalex,scaley,scalez,px,py,pz){

    obj =  new THREE.Mesh(new THREE.BoxGeometry(scalex, scaley, scalez), new THREE.MeshPhongMaterial({ color: "rgb(255,255,255)"}));
    obj.position.x = px;
    obj.position.y = py;
    obj.position.z = pz;
    return obj;
}


var groupAxis = new THREE.Group();
groupAxis.add(xAxis);
groupAxis.add(yAxis);
groupAxis.add(zAxis);

groupAxis.position.x = 50;
groupAxis.position.y = 50;
groupAxis.position.z = 50;
inputX.value =  groupAxis.position.x;
inputY.value =  groupAxis.position.y;
inputZ.value =  groupAxis.position.z;
inputXrotation.value = 0;
inputYrotation.value = 0;
inputZrotation.value = 0;
scene.add(groupAxis);


//defining the sceleton of the Aubo i5 arm
var joint0 = new THREE.Group();
var link1 = createCube(14.05,1,1,14.05/2,0,0);
joint0.add(link1);
var joint1 = new THREE.Group();
var link2 = createCube(1,40.8,1,0,20.4,0);

joint1.add(link2);
joint1.position.x = 14.025;
joint0.add(joint1);
var joint2 = new THREE.Group();
var link3 = createCube(12.15,1,1,-12.15/2,0,0);
var link3_2 = createCube(1,37.6,1,-12,37.6/2,0);
joint2.add(link3);
joint2.add(link3_2);
joint2.position.y = 40.8;
joint1.add(joint2);
var joint3 = new THREE.Group();
var link4 = createCube(10.25,1,1,10.25/2,0,0);
joint3.add(link4);
joint3.position.x = -12.15;
joint3.position.y = 37.6;
joint2.add(joint3); 
var joint4 = new THREE.Group();
var link5 = createCube(1,10.25,1,0,10.25/2,0);
joint4.add(link5);
joint4.position.x = 10.25;
joint3.add(joint4);
var joint5 = new THREE.Group();
var link6 = createCube(9.4,1,1,9.4/2,0,0);
joint5.add(link6);
joint5.position.y = 10.25;
joint4.add(joint5);


joint0.rotateY(THREE.Math.degToRad(090));
joint1.rotateX(THREE.Math.degToRad(00));
joint2.rotateX(THREE.Math.degToRad(00));
joint3.rotateX(THREE.Math.degToRad(-00));
joint4.rotateY(THREE.Math.degToRad(-00));
joint5.rotateX(THREE.Math.degToRad(-00));




scene.add(joint0);

//Translate functions by buttosn 
function xTranlateRight(){
    groupAxis.position.x +=1;
    inputX.value = groupAxis.position.x;

}
function xTranlateLeft(){
    groupAxis.position.x -=1;
    inputX.value = groupAxis.position.x;
}
function yTranlateUp(){
    groupAxis.position.y +=1;
    inputY.value = groupAxis.position.y;
}
function yTranlateDown(){
    groupAxis.position.y -=1;
    inputY.value = groupAxis.position.y;
}
function zTranlateRight(){
    groupAxis.position.z +=1;
    inputZ.value = groupAxis.position.z;
}
function zTranlateLeft(){
    groupAxis.position.z -=1;
    inputZ.value = groupAxis.position.z;
}

//Rotate Function by buttons
function xRotate(){
    groupAxis.position.z +=1;
}
//Update pose of the object after poseUpadte button
function updatePose(){
    groupAxis.position.x = parseFloat(inputX.value);
    groupAxis.position.y = parseFloat(inputY.value);
    groupAxis.position.y = parseFloat(inputZ.value);
    groupAxis.rotation.x = parseFloat(THREE.Math.degToRad(inputXrotation.value));
    groupAxis.rotation.y = parseFloat(THREE.Math.degToRad(inputYrotation.value));
    groupAxis.rotation.z = parseFloat(THREE.Math.degToRad(inputZrotation.value));

}
//loadModel('http://127.0.0.1:8080/large_module_2.obj', 1, -16 + 16, 0, 90, 180, 0);
//loadModel('http://127.0.0.1:8080/large_module_2.obj', 7.5, -7.8 + 16, 0, 0, 90, -90);
//loadModel('http://127.0.0.1:8080/arm_tube_2.obj', 15.6, 28.4 + 16, 0, 90, 0, 0);
//loadModel('http://127.0.0.1:8080/large_module_2.obj', 7.6, 34.5 + 16, 0, 90, 90, 0);
//loadModel('http://127.0.0.1:8080/straight_tube_2.obj', 7.5, 34.5 + 16, 0, 90, 180, 0);
//loadModel('http://127.0.0.1:8080/little_module_2.obj', 7.7, 66.5 + 16, 0, 0, 270, 90);
//loadModel('http://127.0.0.1:8080/little_module_2.obj', 7.5, 66.5 + 16, 0, 180, 90, 90);
//loadModel('http://127.0.0.1:8080/little_module_2.obj', 7.5, 76.3 + 16, 0, 0, 90, 90);

render();