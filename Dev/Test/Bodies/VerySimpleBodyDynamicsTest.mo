within Dev.Test.Bodies;
model VerySimpleBodyDynamicsTest
	Dev.Bodies.VerySimpleBodyDynamics dynamics;
//	Modelica.Mechanics.MultiBody.World world;
	inner Dev.World world;
	Real test_r3;
equation
	test_r3 = dynamics.r_0[3];
end VerySimpleBodyDynamicsTest;