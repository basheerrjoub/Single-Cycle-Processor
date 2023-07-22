-------------------------------------------------------------
-------------------------------------------------------------
--______
--| ___ \
--| |_/ / __ ___   ___ ___  ___ ___  ___  _ __
--|  __//'__/ _ \ / __/ _ \/ __/ __|/ _ \| '__|
--| |  | | | (_) | (_|  __/\__ \__ \ (_) | |
--\_|  |_|  \___/ \___\___||___/___/\___/|_|
--
-------------------------------------------------------------
-------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is

end processor;



--===============================Architecture of the processor==========================
architecture structure of processor is

--4BitAdder
component Adder4 is
    Port(
        add_input: in std_logic_vector(29 downto 0);
        add_output: out std_logic_vector(31 downto 0)
    );
end component;



component MUX4x1 is
    Port ( sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Zero : in  STD_LOGIC_VECTOR (31 downto 0);
           One : in  STD_LOGIC_VECTOR (31 downto 0);
		   Two : in  STD_LOGIC_VECTOR (31 downto 0);
		   Three : in  STD_LOGIC_VECTOR (31 downto 0);
           O : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


--PC Component
component PC is
	Port (
		clk : in std_logic;
		reset : in  STD_LOGIC;
        data_in : in std_logic_vector(31 downto 0);
        data_out : out std_logic_vector(31 downto 0)
    );
end component;

--Instruction Memory Component
component Instruction_Memory is
	port(Address	: in std_logic_vector(31 downto 0);
		Instr: out std_logic_vector(31 downto 0)
	);
end component;


--Register File Component
component RegisterFile is
	Port ( clk : in  STD_LOGIC;
           RegWr : in  STD_LOGIC;
           RA : in  STD_LOGIC_VECTOR (4 downto 0);
           RB : in  STD_LOGIC_VECTOR (4 downto 0);
           RW : in  STD_LOGIC_VECTOR (4 downto 0);
           BUSA : out  STD_LOGIC_VECTOR (31 downto 0);
           BUSB : out  STD_LOGIC_VECTOR (31 downto 0);
           BUSW : in  STD_LOGIC_VECTOR (31 downto 0));
end component;



--ALU component
component ALU is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
		  b : in  STD_LOGIC_VECTOR (31 downto 0);
           SHAMT : in std_logic_vector(4 downto 0);
           ALUOP : in  STD_LOGIC_VECTOR (2 downto 0);
		  zero: out std_logic ;
           rslt : out  STD_LOGIC_VECTOR (31 downto 0);
           negative : out std_logic;
           carry : out std_logic);
end component;


--ALU Control
component ALUControl is
    Port ( ALUType : in  STD_LOGIC_VECTOR (1 downto 0);
           Funct : in  STD_LOGIC_VECTOR (4 downto 0);
           ALUOP : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

--Sign Extender
component Extender is
    Port ( din : in  STD_LOGIC_VECTOR (13 downto 0);
	       ExtOp: in STD_logic;
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--Main Control
component MainControl is
    Port ( TypeCode : in  STD_LOGIC_VECTOR (1 downto 0);
           Funct : in  STD_LOGIC_VECTOR (4 downto 0);
           RegWr, EXTOP, ALUSrc, MemRd, MemWr, WBdata, RegSrc, SHFTSrc : out  std_logic);
end component;

--MUX2x1Reg
component MUX2x1Reg is
    Port ( sel : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR (4 downto 0);
           B : in  STD_LOGIC_VECTOR (4 downto 0);
           O : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

--MUX2x1
component MUX2x1 is
    Port ( sel : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           O : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

--Data Memory
component DataMemory is
port(clk:		in std_logic;
	Read:		in std_logic;
	Write:		in std_logic;
    Address:      in std_logic_vector(31 downto 0);
	Data_in: 	in std_logic_vector(31 downto 0);
	Data_out: 	out std_logic_vector(31 downto 0)
);
end component;

--Adder Branch
component BranchAdder is
    port (
        pc : in  std_logic_vector(31 downto 0);
        extend : in  std_logic_vector(31 downto 0);
        branchTarget : out std_logic_vector(31 downto 0)
    );
end component;

--PC Control
component PCControl is
    Port (clk : in STD_LOGIC;
	      TypeCode : in  STD_LOGIC_VECTOR (1 downto 0);
		  stop: in STd_logic;
		  ALUzero: in STd_logic;
          Funct : in  STD_LOGIC_VECTOR (4 downto 0);
		  stackWr, stackRd: out STd_logic;
		  PCSrc: out STD_LOGIC_VECTOR(1 downto 0));
end component;

component SP is
    Port ( clk : in  STD_LOGIC;
           write, read : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component SP;

signal branchTargetT, adder_in,addr32_pc_next, adder_out, pc_out, pc_in, busAT, busBT,busWT, InstrT, ExtOut, ALUINB, ALUOUT, DMemOut, topOfStack: std_logic_vector(31 downto 0);
signal ALUOPTemp: STD_LOGIC_VECTOR (2 downto 0);
signal SReg, SHFTCount: STD_LOGIC_VECTOR (4 downto 0);
signal RegWrT, EXTOPT, ALUSrcT, MemRdT, MemWrT, WBdataT, ALUZeroT, RegSrcT, SHFTSrcT, stackWrT, stackRdT , carryT, negativeT:  std_logic;
signal PCSrcT: STD_LOGIC_VECTOR(1 downto 0);
signal clk : std_logic := '0';
signal reset : std_logic := '1';
constant clk_period : time := 50 ns;
--====================Code Start of Processor =====================
begin

	-- Adder block
    adder_block: Adder4 port map(add_input => adder_in(31 downto 2), add_output => adder_out);

	-- PC block
	pc_block: PC port map(clk=> clk, reset=>reset, data_in => pc_in, data_out => pc_out);
	adder_in <= pc_out;

	-- Instruction MEM Block
	IM_block: Instruction_Memory port map (Address => pc_out, Instr => InstrT);

	--SourceRegister Source MUX									RS2						RD
	REGMUX_block: MUX2x1Reg port map(sel=>RegSrcT, A=>InstrT(16 downto 12), B=>InstrT(21 downto 17), O=>SReg);

	--SHIFT Source MUX									0-->inst					1-->R
	SHFTSRC_block: MUX2x1Reg port map(sel=>SHFTSrcT, A=>InstrT(11 downto 7), B=>ALUINB(4 downto 0), O=>SHFTCount);

	-- Register File block
	RF_block: RegisterFile port map (clk=> clk,RegWr=>RegWrT, RA=> InstrT(26 downto 22), RB=> SReg, RW=> InstrT(21 downto 17), BUSA=> busAT, BUSB=> busBT, BUSW=> busWT);

	-- ALU Control Block
	ALUCont_block: ALUControl port map(ALUType=>InstrT(2 downto 1), Funct=>InstrT(31 downto 27), ALUOP=>ALUOPTemp);

	-- ALU Block
	ALU_block: ALU port map (a=> busAT, b=> ALUINB, SHAMT=>SHFTCount, ALUOP=>ALUOPTemp, rslt=>ALUOUT, zero=> ALUZeroT, negative=> negativeT, carry=> carryT);

	--Extender
	Extender_block: Extender port map(din=>InstrT(16 downto 3), ExtOp=>EXTOPT, dout=>ExtOut);

	--ALUMUX
	ALUMUX_block: MUX2x1 port map(sel=>ALUSrcT,A=>busBT, B=>ExtOut, O=>ALUINB);

	--Main Control
	MainCont_block: MainControl port map(TypeCode=> InstrT(2 downto 1), Funct=>InstrT(31 downto 27), RegWr=> RegWrT, EXTOP=>EXTOPT, ALUSrc=>ALUSrcT, MemRd=>MemRdT, MemWr=>MemWrT, WBdata=>WBdataT, RegSrc=>RegSrcT, SHFTSrc=>SHFTSrcT);

	--Data Memory
	DataMem_block: DataMemory port map(clk=>clk, Read=>MemRdT, Write=>MemWrT, Address=>ALUOUT, Data_in=>busBT, Data_out=>DMemOut);

	--MEMMUX
	MEMmux_block: MUX2x1 port map(sel=>WBdataT,A=>ALUOUT, B=>DMemOut, O=>busWT);

	--addr32_pc_next for the Two Input
	addr32_pc_next <= std_logic_vector((unsigned("00000" & InstrT (26 downto 3) & "00")) + unsigned(pc_out));

	--Stack pointer
	SP_block: SP port map(clk=>clk, write=>stackWrT, read=>stackRdT, data_in=>adder_out ,data_out=>topOfStack);

	-- MUX for Choosing the next PC Instruction
	MUX4x1_block: MUX4x1 port map(sel=>PCSrcT, Zero=> adder_out, One=> addr32_pc_next, Two=> branchTargetT, Three=>topOfStack, O=>pc_in);

	--Branch Adder
	BranchAdder_block: BranchAdder port map(pc=>adder_out, extend=>ExtOut, branchTarget=>branchTargetT);

	--PC Control
	PCControl_block: PCControl port map(clk=>clk, TypeCode=> InstrT(2 downto 1), stop=> InstrT(0) ,Funct=>InstrT(31 downto 27), ALUzero=>ALUZeroT,stackWr=>stackWrT, stackRd=>stackRdT, PCSrc=>PCSrcT);



	  -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 10 ns.
      wait for 10 ns;
      reset <= '0';
      -- insert stimulus here

      wait;
   end process;
end structure;
