----------------------------------------------------------------------------------
---              Feature extraction + Classification
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.cnn_types.all;

entity main is
    port(
        --- inputy ports
        clk        : in std_logic;
        wr_data    : in std_logic_vector(7 downto 0);
        wr_en      : in std_logic := '0';
        i_rst_sync : in std_logic := '0';

        --- output ports
        node_one    : out signed(21 downto 0) := (others => '0');
        node_two    : out signed(21 downto 0) := (others => '0');
        node_three  : out signed(21 downto 0) := (others => '0');
        node_four   : out signed(21 downto 0) := (others => '0')
    );
end main;

architecture Behavioral of main is
    --- component of feature extraction
    component main_feature
        port(
            clk                  : in std_logic;
            wr_data              : in std_logic_vector(7 downto 0);
            wr_en                : in std_logic := '0';
            i_rst_sync           : in std_logic := '0';
            feature_result_one   : out signed(13 downto 0);
            feature_result_two   : out signed(13 downto 0);
            feature_result_three : out signed(13 downto 0);
            feature_result_four  : out signed(13 downto 0);
            feature_result_en    : out state 
        );
    end component;

    --- Component of classification
    component main_class
        port(
            clk : in std_logic;
            feature_result_one   : in signed(13 downto 0);
            feature_result_two   : in signed(13 downto 0);
            feature_result_three : in signed(13 downto 0);
            feature_result_four  : in signed(13 downto 0);
            feature_result_en    : in state;
            node_one             : out signed(21 downto 0);
            node_two             : out signed(21 downto 0);
            node_three           : out signed(21 downto 0);
            node_four            : out signed(21 downto 0)
        );
    end component;

    --- Define signals
    signal feature_result_one   : signed(13 downto 0);
    signal feature_result_two   : signed(13 downto 0);
    signal feature_result_three : signed(13 downto 0);
    signal feature_result_four  : signed(13 downto 0);
    signal feature_result_en    : state; 

begin

--- instance of Feature extraction
main_feature_ins : main_feature
    port map(
        clk                  => clk,
        wr_data              => wr_data,
        wr_en                => wr_en,
        i_rst_sync           => i_rst_sync,
        feature_result_one   => feature_result_one,
        feature_result_two   => feature_result_two,
        feature_result_three => feature_result_three,
        feature_result_four  => feature_result_four,
        feature_result_en    => feature_result_en
    );

--- instance of Classification
main_class_ins : main_class
    port map(
        clk                  => clk,
        feature_result_one   => feature_result_one,
        feature_result_two   => feature_result_two,
        feature_result_three => feature_result_three,
        feature_result_four  => feature_result_four,
        feature_result_en    => feature_result_en,
        node_one             => node_one,
        node_two             => node_two,
        node_three           => node_three,
        node_four            => node_four
    );

    
end Behavioral;

