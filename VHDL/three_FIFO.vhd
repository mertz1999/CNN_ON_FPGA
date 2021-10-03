----------------------------------------------------------------------------------
---               Combine Three FIFO line 
--- Bahman 1399
--- ازون جایی که قراره ما سه خط فیفو داشته باشیم که خروجی اولی به
--- ورودی دومی وصل میشه و خورجی دومی به ورودی سومی نیز متصل میشود
--- و در نهایت نه دیتای مدنظر ما به عنوان خروجی این قسمت خواهیم
--- داشت که میدیمیش به بخش محاسباتی که کار رو برای ما کامل کنه
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity three_FIFO is
    generic(
        g_width : natural := 5;
        g_depth : integer := 5
    );
    port(
        --- Clock port
        clk : in std_logic;

        --- FIFO Write data
        wr_data : in std_logic_vector(g_width-1 downto 0);
        wr_en   : in std_logic;

        --- reset system
        i_rst_sync : in  std_logic;

        --- output
        a00,a01,a02,a10,a11,a12,a20,a21,a22 : out std_logic_vector(g_width-1 downto 0)

    );
end three_FIFO;


--- Define architecture
architecture Behavioral of three_FIFO is
    --- Loading FIFO Component
    COMPONENT FIFO
    generic(
        g_width : natural ;
        g_depth : integer 
    );
    PORT(
         i_rst_sync : IN  std_logic;
         i_clk : IN  std_logic;
         i_wr_en : IN  std_logic;
         i_wr_data : IN  std_logic_vector(g_width-1 downto 0) := (others => '0');
         o_rd_data_1,o_rd_data_2,o_rd_data_3 : OUT  std_logic_vector(g_width-1 downto 0)
        );
    END COMPONENT;


    --- Define all necessary signals
    signal t_a20,t_a10 : std_logic_vector(g_width-1 downto 0);

begin
    --- make three FIFO and portmap
    --- FIFO one
    line1 : FIFO
    GENERIC MAP(g_width => g_width, g_depth => g_depth)
    PORT MAP(
        i_rst_sync  => i_rst_sync,
        i_clk       => clk,
        i_wr_en     => wr_en,
        i_wr_data   => wr_data,
        o_rd_data_1 => t_a20,
        o_rd_data_2 => a21,
        o_rd_data_3 => a22       
    );
    --- FIFO tow
    line2 : FIFO
    GENERIC MAP(g_width => g_width, g_depth => g_depth)
    PORT MAP(
        i_rst_sync  => i_rst_sync,
        i_clk       => clk,
        i_wr_en     => wr_en,
        i_wr_data   => t_a20,
        o_rd_data_1 => t_a10,
        o_rd_data_2 => a11,
        o_rd_data_3 => a12       
    );
    --- FIFO three
    line3 : FIFO 
    GENERIC MAP(g_width => g_width, g_depth => g_depth)
    PORT MAP(
        i_rst_sync  => i_rst_sync,
        i_clk       => clk,
        i_wr_en     => wr_en,
        i_wr_data   => t_a10,
        o_rd_data_1 => a00,
        o_rd_data_2 => a01,
        o_rd_data_3 => a02    
    );

    --- connect temporarity signal
    a20 <= t_a20;
    a10 <= t_a10;


end Behavioral;

