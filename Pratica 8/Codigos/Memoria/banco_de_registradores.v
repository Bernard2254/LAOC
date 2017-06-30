module bancoRegistradores(clk, entrada1, entrada2, registradorEscrita, dado, write, saida1, saida2, clr);
	input clk, write, clr;
	input [3:0] entrada1, entrada2, registradorEscrita;
	input [7:0] dado;
	output reg [7:0] saida1, saida2;
	integer i;

	reg[7:0] regs[15:0];

	initial
	begin
		for(i=0; i<15; i=i+1)
			regs[i] <= 8'b00000000;
		saida1 <= 8'b00000000;
		saida2 <= 8'b00000000;
	end

	always @(negedge clk & ~write)
	begin
		if(~clr)
		begin
			saida1 <= regs[entrada1];
			saida2 <= regs[entrada2];
		end
	end

	always @(posedge clk & write)
	begin
		if(~clr)
		begin
			regs[registradorEscrita] <= dado;		
		end
	end

	always @(clr)
	begin
		for(i=0; i<15; i=i+1)
			regs[i] <= 8'b00000000;
		saida1 <= 8'b00000000;
		saida2 <= 8'b00000000;
	end

endmodule

module testeBancoRegistradores();
	reg write, clk, clr;
	reg [3:0] entrada1, entrada2, registradorEscrita;
	reg [7:0] dado;
	wire [7:0] saida1, saida2;

	integer i;
	
	always
	begin
	    #1 begin
	            clk = ~clk;
	        if(write & ~clk)
    	        begin
        			registradorEscrita <= registradorEscrita+1;
        			dado <= dado+1;
    			end
			if(~write & clk)
    			begin
    			    dado<=8'b0000000;
    			    entrada1 = entrada1+1;
    			end
	    end
	end

	initial
	begin
		write<=1;
		clk<=0;
		clr<=0;
		entrada1<=8'b0000;
		entrada2<=8'b0000;
		registradorEscrita<=8'b0000;
		dado<=8'b00000000;
		#32 begin
		    write<=0;
		    entrada1 = 4'b1111;
		end
		#32 $finish;
	end
	
	initial
	begin
		$monitor("Time = %0d Clock = %b Entrada1 = %b Entrada2 = %b registradorEscrita = %b Dado = %b Saida1 = %b Saida2 = %b Write = %0d",$time, clk, entrada1 ,entrada2, registradorEscrita, dado, saida1, saida2, write);
	end

	bancoRegistradores teste(clk, entrada1, entrada2, registradorEscrita, dado, write, saida1, saida2, clr);
endmodule