from migen import *
from litex.soc.interconnect.csr import *
from litex.soc.interconnect import wishbone

class FastVDMA(Module, AutoCSR):
    def __init__(self, platform):
        platform.add_sources("DMATop.v")

        self.control_dat_i   = Signal(32)
        self.constrol_dat_o  = Signal(32)
        self.control_cyc_i   = Signal()
        self.control_stb_i   = Signal()
        self.control_we_i    = Signal()
        self.control_adr_i   = Signal(32)
        self.control_sel_i   = Signal(32)
        self.control_ack_o   = Signal()
        self.control_stall_o = Signal()
        self.control_err_o   = Signal()

        self.read_dat_i    = Signal(32)
        self.read_dat_o    = Signal(32)
        self.read_cyc_o    = Signal()
        self.read_stb_o    = Signal()
        self.read_we_o     = Signal()
        self.read_adr_o    = Signal(32)
        self.read_sel_o    = Signal(4)
        self.read_ack_i    = Signal()
        self.read_stall_i  = Signal()
        self.read_err_i    = Signal()
        
        self.write_dat_i   = Signal(32)
        self.write_dat_o   = Signal(32)
        self.write_cyc_o   = Signal()
        self.write_stb_o   = Signal()
        self.write_we_o    = Signal()
        self.write_adr_o   = Signal(32)
        self.write_sel_o   = Signal(4)
        self.write_ack_i   = Signal()
        self.write_stall_i = Signal()
        self.write_err_i   = Signal() 
        
        self.irq_readerDone = Signal()
        self.irq_writerDone = Signal()
        
        self.sync_readerSync = Signal()
        self.sync_writerSync = Signal()

        self.specials += Instance("DMATop",
                            i_clock = ClockSignal(),
                            i_reset = ~ResetSignal(),
                            i_io_control_dat_i   = self.control_dat_i,
                            o_io_constrol_dat_o  = self.constrol_dat_o,
                            i_io_control_cyc_i   = self.control_cyc_i,
                            i_io_control_stb_i   = self.control_stb_i,
                            i_io_control_we_i    = self.control_we_i,
                            i_io_control_adr_i   = self.control_adr_i,
                            i_io_control_sel_i   = self.control_sel_i,
                            o_io_control_ack_o   = self.control_ack_o,
                            o_io_control_stall_o = self.control_stall_o,
                            o_io_control_err_o   = self.control_err_o,
                            
                            i_io_read_dat_i    = self.read_dat_i,
                            o_io_read_dat_o    = self.read_dat_o,
                            o_io_read_cyc_o    = self.read_cyc_o,
                            o_io_read_stb_o    = self.read_stb_o,
                            o_io_read_we_o     = self.read_we_o,
                            o_io_read_adr_o    = self.read_adr_o,
                            o_io_read_sel_o    = self.read_sel_o,
                            i_io_read_ack_i    = self.read_ack_i,
                            i_io_read_stall_i  = self.read_stall_i,
                            i_io_read_err_i    = self.read_err_i,

                            i_io_write_dat_i   = self.write_dat_i,
                            o_io_write_dat_o   = self.write_dat_o,
                            o_io_write_cyc_o   = self.write_cyc_o,
                            o_io_write_stb_o   = self.write_stb_o,
                            o_io_write_we_o    = self.write_we_o,
                            o_io_write_adr_o   = self.write_adr_o,
                            o_io_write_sel_o   = self.write_sel_o,
                            i_io_write_ack_i   = self.write_ack_i,
                            i_io_write_stall_i = self.write_stall_i,
                            i_io_write_err_i   = self.write_err_i,

                            o_io_irq_readerDone = self.irq_readerDone,
                            o_io_irq_writerDone = self.irq_writerDone,

                            i_io_sync_readerSync = self.sync_readerSync,
                            i_io_sync_writerSync = self.sync_writerSync)
