module Add(entrada1, entrada2, saida, clk, clr);
	input [7:0] entrada1, entrada2;
	input clk, clr;
	output reg [7:0] saida;

	always @(posedge clk)
	begin
		if(~clr)
			saida <= entrada1+entrada2;
	end

	always @(clr)
	begin
		saida <= 8'b00000000;
	end
endmodule

module Sub(entrada1, entrada2, saida, clk, clr);
	input [7:0] entrada1, entrada2;
	input clk, clr;
	output reg [7:0] saida;

	always @(posedge clk)
	begin
		if(~clr)
			saida <= entrada1 - entrada2;
	end

	always @(clr)
	begin
		saida <= 8'b00000000;
	end
endmodule

module Or(entrada1, entrada2, saida, clk, clr);
	input[7:0] entrada1, entrada2;
	input clk, clr;
	output reg [7:0] saida;

	always @(posedge clk)
	begin
		saida = (entrada1 | entrada2);
	end

	always @(clr)
	begin
		saida<=8'b00000000;
	end
endmodule

module And(entrada1, entrada2, saida, clk, clr);
	input[7:0] entrada1, entrada2;
	input clk, clr;
	output reg [7:0] saida;

	always @(posedge clk)
	begin
		saida = (entrada1 & entrada2);
	end

	always @(clr)
	begin
		saida<=8'b00000000;
	end
endmodule

module Not(entrada, saida, clk, clr);
	input[7:0] entrada;
	input clk, clr;
	output reg [7:0] saida;
    integer i;
    
	always @(posedge clk)
	begin
		for(i=0; i<8; i++)
			saida[i] <= ~entrada[i];
	end

	always @(clr)
	begin
		saida<=8'b00000000;
	end
endmodule

module Set_less_than(entrada1, entrada2, saida, clk, clr);
	input[7:0] entrada1, entrada2;
	input clk, clr;
	output reg [7:0] saida;

	always @(posedge clk)
	begin
		if(entrada1<entrada2)
			saida <=8'b00000001;
		else
			saida <=8'b00000000;
	end

	always @(clr)
	begin
		saida<=8'b00000000;
	end
endmodule

module testeAdd();
	reg clk, clr;
	reg [7:0] entrada1, entrada2;
	wire [7:0] saida;

	always
	begin
		#1 begin
			clk = ~clk;
			if (clk) begin
				entrada1 = entrada1+1;
			    entrada2 = entrada2+1;
			end
		end
	end

	initial
	begin
		clr<=0;
		clk<=0;
		entrada1<=8'b00000000;
		entrada2<=8'b00000000;
		#512 $finish;
	end

	initial
	begin
		$monitor("Time = %0d Clock = %b Entrada1 = %b Entrada2 = %b Saida = %b", $time, clk, entrada1, entrada2, saida);
	end

	Add teste(entrada1, entrada2, saida, clk, clr);

endmodule

module testeSub();
	reg clk, clr;
	reg [7:0] entrada1, entrada2;
	wire [7:0] saida;
	integer i=5;

	always
	begin
		#1 begin
			i++;
			clk = ~clk;
			if (clk) begin
				entrada1 = entrada1+i*2;
			    entrada2 = entrada2+1;
			end
		end
	end

	initial
	begin
		clr<=0;
		clk<=0;
		entrada1<=8'b00000000;
		entrada2<=8'b00000000;
		#512 $finish;
	end

	initial
	begin
		$monitor("Time = %0d Clock = %b Entrada1 = %b Entrada2 = %b Saida = %b", $time, clk, entrada1, entrada2, saida);
	end

	Sub teste(entrada1, entrada2, saida, clk, clr);

endmodule

module testeSlt();
	reg clk, clr;
	reg [7:0] entrada1, entrada2;
	wire [7:0] saida;
	integer i = 0;

	always
	begin
		#1 begin
			clk = ~clk;
			if (clk) begin
				if (i%256==0)
					entrada2++;
				i++;
				entrada1++;
			end
		end

	end

	initial
	begin
		clr<=0;
		clk<=0;
		entrada1<=8'b00000000;
		entrada2<=8'b00000000;
		#(512*256) $finish;
	end

	initial
	begin
		$monitor("Time = %0d Clock = %b Entrada1 = %b Entrada2 = %b Saida = %b", $time, clk, entrada1, entrada2, saida);
	end

	Set_less_than teste(entrada1, entrada2, saida, clk, clr);

endmodule

module testeNot();
	reg clk, clr;
	reg [7:0] entrada;
	wire [7:0] saida;

	always
	begin
		#1 begin
			clk = ~clk;
			if (clk) begin
				entrada1 = entrada1+1;
			end
		end
	end

	initial
	begin
		clr<=0;
		clk<=0;
		entrada<=8'b00000000;
		#255 $finish;
	end

	initial
	begin
		$monitor("Time = %0d Clock = %b Entrada = %b  Saida = %b", $time, clk, entrada, saida);
	end

	Not teste(entrada, saida, clk, clr);

endmodule

module testeOr();
	reg clk, clr;
	reg [7:0] entrada1, entrada2;
	wire [7:0] saida;
	integer i = 0;

	always
	begin
		#1 begin
			clk = ~clk;
			if (clk) begin
				if (i%256==0)
					entrada2++;
				i++;
				entrada1++;
			end
		end

	end

	initial
	begin
		clr<=0;
		clk<=0;
		entrada1<=8'b00000000;
		entrada2<=8'b00000000;
		#(512*256) $finish;
	end

	initial
	begin
		$monitor("Time = %0d Clock = %b Entrada1 = %b Entrada2 = %b Saida = %b", $time, clk, entrada1, entrada2, saida);
	end

	Or teste(entrada1, entrada2, saida, clk, clr);

endmodule

module testeAnd();
	reg clk, clr;
	reg [7:0] entrada1, entrada2;
	wire [7:0] saida;
	integer i = 0;

	always
	begin
		#1 begin
			clk = ~clk;
			if (clk) begin
				if (i%256==0)
					entrada2++;
				i++;
				entrada1++;
			end
		end

	end

	initial
	begin
		clr<=0;
		clk<=0;
		entrada1<=8'b00000000;
		entrada2<=8'b00000000;
		#(512*256) $finish;
	end

	initial
	begin
		$monitor("Time = %0d Clock = %b Entrada1 = %b Entrada2 = %b Saida = %b", $time, clk, entrada1, entrada2, saida);
	end

	And teste(entrada1, entrada2, saida, clk, clr);

endmodule