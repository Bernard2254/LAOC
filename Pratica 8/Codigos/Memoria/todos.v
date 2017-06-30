module registrador_up (entrada, saida, clk, clr);
  input [7:0]entrada;
  input clk, clr;
  output reg [7:0]saida;
  
  always @(posedge clk)
  begin
	if(~clr)
	    saida <= entrada;
  end

  always @(clr)
  begin
	saida<= 8'b00000000;
  end
endmodule

module memoriaDados(clk, read, write, endereco, dado, saida, clr);
	input clk, read, write, clr;
	input [7:0] endereco, dado;
   	output reg [7:0] saida;

	reg [7:0]mem[255:0];

	integer i;

	initial
	begin
		for(i=0; i<256; i=i+1)
			mem[i]<=8'b00000000;
		saida <= 8'b00000000;
	end

	always @(negedge clk & read)
	begin
		if(~clr)
			saida<=mem[endereco];
	end

	always @(posedge  clk & write)
	begin
		if(~clr)
			begin
				mem[endereco] <= dado;
				saida <= dado;
			end
	end

	always @(clr)
	begin
		for(i=0; i<256; i=i+1)
			mem[i]<=8'b00000000;
		saida <= 8'b00000000;
	end
endmodule

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


module testeReg();
  reg clock, clr;
  reg [7:0] entrada;
  wire [7:0] saida;
  
  always
  begin
    #1 begin
    	clock <= ~clock;
    	if(~clock)
    		entrada <=  entrada+1;
    end
  end
  
  initial
  begin
       clr<=0;
       clock <=0; 
       entrada <=  8'b00000001;
      #256 $finish;
  end
  
  initial
  begin
    $monitor("Time = %0d Clock = %b Entrada = %b Saida = %b",$time, clock, entrada ,saida);
  end
  
  registrador_up register(entrada, saida, clock, clr);
  
endmodule

module testeMemDados();
	reg clock, clr, write, read;
	reg [7:0] endereco, dado;
	wire [7:0] saida;

	always
	begin
		#1 begin 
			clock <= ~clock;
			dado<=dado+1;
			if($time != 255)
			    endereco <=  endereco+1;
		end
	end
	
	initial
	begin
		dado<=1;
		read<=0;
		write<=1;
		clr<=0;
       		clock <=0; 
       		endereco <=  8'b00000000;
		#256 begin
			write<=0;
			read<=1;
		end
		#256 $finish;
	end

	initial
	begin
		$monitor("Time = %0d Clock = %b Endereco = %b Saida = %b Dado = %b Write = %0d Read = %0d",$time, clock, endereco ,saida, dado, write, read);
	end
	

	memoriaDados teste(clock, read, write, endereco, dado, saida, clr);
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
