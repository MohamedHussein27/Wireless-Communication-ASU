# 📡 Wireless Network Planner (MATLAB)

A MATLAB-based planning tool for wireless cellular networks in the 900 MHz band. This tool helps network designers analyze and compare different sectorization techniques and evaluate the impact of user density, Grade of Service (GOS), and SIR requirements on network infrastructure.

---

## 📁 Project Structure

- `wireless_network_planner.m`  
  Main script that sets parameters and calls plotting functions.

- `generate_plots.m`  
  Generates visualizations for four planning scenarios using multiple sectorization methods.

- `calculate_network_params.m`  
  Core function performing network parameter calculations based on inputs.

- `calculate_cluster_size.m`  
  Computes the minimum cluster size required to meet specific SIR requirements.

---

## ⚙️ Features

### ✅ Comparative Sectorization Analysis
Simultaneous evaluation of:
- **Omnidirectional antennas**
- **120° sectorization (3 sectors)**
- **60° sectorization (6 sectors)**

### 📊 Four Key Analysis Scenarios

| Scenario | Fixed Parameters | Varied Parameter | Output |
|----------|------------------|------------------|--------|
| **1. Cells vs GOS (SIR = 19 dB)** | SIR = 19 dB, User Density = 1400 users/km² | GOS (Blocking Probability) | Number of cells and traffic intensity per cell |
| **2. Cells vs GOS (SIR = 14 dB)** | SIR = 14 dB, User Density = 1400 users/km² | GOS | Impact of relaxed SIR on cell count |
| **3. Cells & Radius vs User Density (SIR = 14 dB)** | SIR = 14 dB, GOS = 2% | User Density | Network scalability with user growth |
| **4. Cells & Radius vs User Density (SIR = 19 dB)** | SIR = 19 dB, GOS = 2% | User Density | Effect of stricter SIR on coverage and cells |

---

## 📐 Technical Details

### 🔢 Cluster Size Calculation
- Based on **standard cellular interference formulas**.
- Interfering cell assumptions per configuration:
  - Omnidirectional: 6 interferers
  - 120° sectorization: 2 per sector
  - 60° sectorization: 1 per sector

### 📶 Traffic & Capacity Modeling
- Uses **Erlang B** for traffic capacity estimation.
- Implements **linear interpolation** for intermediate GOS values.
- Includes **approximation** for out-of-range Erlang values.

### 🗺️ Cell Planning Logic
- Considers:
  - User density
  - Traffic per user: `0.025 Erlang`
  - Max traffic per sector/cell
- Calculates **cell count** and **radius** using a hexagonal model.

---

## 📈 Visualization Strategy

- Each figure contains **2 subplots** for comprehensive comparison.
- Uses consistent **coloring**, **line styles**, and **legend formatting**.
- Adds **grid lines**, **labels**, and **titles** for readability.

### 🔍 Plot Breakdown

#### GOS Analysis
- **Top Subplot**: Number of Cells vs GOS
- **Bottom Subplot**: Traffic per Cell vs GOS

#### User Density Analysis
- **Top Subplot**: Number of Cells vs User Density
- **Bottom Subplot**: Cell Radius vs User Density

---

## 📌 How to Use

1. Open MATLAB and navigate to the project directory.
2. Run the main script:
   ```matlab
   wireless_network_planner
