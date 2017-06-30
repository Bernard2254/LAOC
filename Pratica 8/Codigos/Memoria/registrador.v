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