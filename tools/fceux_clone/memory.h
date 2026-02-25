// 8BitStudio FCEUX Clone - Memory
#pragma once

class Memory {
public:
    void Reset();
    uint8_t Read(uint16_t addr);
    void Write(uint16_t addr, uint8_t value);
    // TODO: ROM, RAM, I/O mapping
};
