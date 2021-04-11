namespace minSpace
{
	open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic; 
    open Microsoft.Quantum.Arrays; 
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

	operation findMin(): Unit
	{
		// The numbers to be compared
		use a = Qubit[2];
		use b = Qubit[2];
		X(b[0]);

        RunGroversSearch(a, b);
        // print the resulting state of the system
        DumpMachine();

        X(b[0]);
	}

    operation minOracle(a : Qubit[], b : Qubit[]) : Unit is Adj + Ctl
    {
    	within
    	{
    		X(a[0]);
    		X(b[0]);
    		X(a[1]);
    		X(b[1]);
    	}
    	apply
    	{	
    		// Applying operation on MSB
    		CCNOT(a[1], b[1], a[1]);
    		// Applying operations on LSB
    		CCNOT(a[1], b[0], a[0]);
	    	X(b[1]);
	    	CCNOT(a[1], b[1], a[0]);
	    	X(a[1]);
	    	X(b[1]);
	    	Controlled X([a[1], b[0], b[1]], a[0]);
	    	X(a[1]);
    	}
    }

    operation ReflectAboutUniform(digitReg : Qubit[]) : Unit {
        within {
            Adjoint PrepareUniformSuperpositionOverDigits(digitReg);
            ApplyToEachCA(X, digitReg);
        } apply {
            Controlled Z(Most(digitReg), Tail(digitReg));
        }
    }

    operation PrepareUniformSuperpositionOverDigits(digitReg : Qubit[]) : Unit is Adj + Ctl {
        PrepareArbitraryStateCP(ConstantArray(4, ComplexPolar(1.0, 0.0)), LittleEndian(digitReg));
    }

    operation RunGroversSearch(register1 : Qubit[], register2 : Qubit[]) : Unit {
        ApplyToEach(H, register1);
        ApplyToEach(H, register2);
        minOracle(register1, register2);
        ReflectAboutUniform(register1);
        ReflectAboutUniform(register2);
    }
}
