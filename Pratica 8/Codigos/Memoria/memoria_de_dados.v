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