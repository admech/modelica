within Dev.Interfaces.Impl;

model ContactPortStub
	Dev.Interfaces.ContactPort port;
	
	Real alpha;
equation
	
	port.frame.f = zeros(3);
	port.frame.t = zeros(3);
	
	port.point = alpha * {0, 0, -1};

end ContactPortStub;