within Dev.Test.Bodies;
model SimpleBodyDynamicsTest
//	inner Modelica.Mechanics.MultiBody.World world;
	inner Dev.World world;
	Dev.Bodies.SimpleBodyDynamics dynamics;
	
	Real test_r3;
equation
	test_r3 = dynamics.r_0[3];
end SimpleBodyDynamicsTest;