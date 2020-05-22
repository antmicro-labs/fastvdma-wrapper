import os
from migen import *
from litex.soc.interconnect import wishbone

class FastVDMA(Module):
    def __init__(self, platform):
        platform.add_sources(os.path.abspath(os.path.dirname(__file__)),
                             "DMATop.v")

        self.control = control_bus = wishbone.Interface(data_width=32, adr_width=32)
        self.read    = read_bus    = wishbone.Interface(data_width=32, adr_width=32) 
        self.write   = write_bus   = wishbone.Interface(data_width=32, adr_width=32)

        self.control_stall = Signal()
        self.read_stall = Signal()
        self.write_stall = Signal()
        
        self.irq_readerDone = Signal()
        self.irq_writerDone = Signal()
        
        self.sync_readerSync = Signal()
        self.sync_writerSync = Signal()

        self.specials += Instance("DMATop",
                            i_clock = ClockSignal(),
                            i_reset = ~ResetSignal(),
                            # slave
                            i_io_control_dat_i   = control_bus.dat_w,
                            o_io_control_dat_o   = control_bus.dat_r,
                            i_io_control_cyc_i   = control_bus.cyc,
                            i_io_control_stb_i   = control_bus.stb,
                            i_io_control_we_i    = control_bus.we,
                            i_io_control_adr_i   = control_bus.adr,
                            i_io_control_sel_i   = control_bus.sel,
                            o_io_control_ack_o   = control_bus.ack,
                            o_io_control_stall_o = self.control_stall, 
                            o_io_control_err_o   = control_bus.err,
                            # master
                            i_io_read_dat_i    = read_bus.dat_r,
                            o_io_read_dat_o    = read_bus.dat_w,
                            o_io_read_cyc_o    = read_bus.cyc,
                            o_io_read_stb_o    = read_bus.stb,
                            o_io_read_we_o     = read_bus.we,
                            o_io_read_adr_o    = read_bus.adr,
                            o_io_read_sel_o    = read_bus.sel,
                            i_io_read_ack_i    = read_bus.ack,
                            i_io_read_stall_i  = self.read_stall,
                            i_io_read_err_i    = read_bus.err,
                            # master
                            i_io_write_dat_i   = write_bus.dat_r,
                            o_io_write_dat_o   = write_bus.dat_w,
                            o_io_write_cyc_o   = write_bus.cyc,
                            o_io_write_stb_o   = write_bus.stb,
                            o_io_write_we_o    = write_bus.we,
                            o_io_write_adr_o   = write_bus.adr,
                            o_io_write_sel_o   = write_bus.sel,
                            i_io_write_ack_i   = write_bus.ack,
                            i_io_write_stall_i = self.write_stall,
                            i_io_write_err_i   = write_bus.err,

                            o_io_irq_readerDone = self.irq_readerDone,
                            o_io_irq_writerDone = self.irq_writerDone,

                            i_io_sync_readerSync = self.sync_readerSync,
                            i_io_sync_writerSync = self.sync_writerSync)
        self.comb += [
            self.control_stall.eq(0),
            self.read_stall.eq(0),
            self.write_stall.eq(0)
        ]
