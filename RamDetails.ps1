# ===============================================
# Script: Get-RAMInfo.ps1
# Purpose: Display detailed RAM info including
# Manufacturer, Capacity (GB), Speed, DDR version,
# Configured speed, total slots, used slots, max capacity
# ===============================================

# Function to decode DDR version from SMBIOSMemoryType
function Get-DDRType($type){
    switch ($type){
        20 {"DDR"}
        21 {"DDR2"}
        22 {"DDR2 FB-DIMM"}
        24 {"DDR3"}
        26 {"DDR4"}
        27 {"LPDDR"}
        28 {"LPDDR2"}
        29 {"LPDDR3"}
        30 {"LPDDR4"}
        34 {"DDR5"}
        default {"Unknown"}
    }
}

# Get RAM and motherboard info
$mem = Get-CimInstance Win32_PhysicalMemory
$board = Get-CimInstance Win32_PhysicalMemoryArray

# Display per stick info
Write-Host "=== Installed RAM Modules ==="
$mem | ForEach-Object {
    [PSCustomObject]@{
        Manufacturer        = $_.Manufacturer
        RamCapacity         = [math]::Round($_.Capacity/1GB,2)
        Speed_MHz           = $_.Speed
        ConfiguredSpeed_MHz = $_.ConfiguredClockSpeed
        DDR_Version         = Get-DDRType $_.SMBIOSMemoryType
    }
} | Format-Table -AutoSize

# Display motherboard total slots and max capacity
Write-Host "`n=== Motherboard RAM Info ==="
[PSCustomObject]@{
    TotalSlots     = $board.MemoryDevices
    UsedSlots      = $mem.Count
    MaxCapacitySupports = [math]::Round(($board.MaxCapacity/1048576),2)
} | Format-Table -AutoSize
	