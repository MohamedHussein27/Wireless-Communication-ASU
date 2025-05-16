function wireless_network_analysis()
    % Main function for wireless network planning analysis
    city_area = 100; % km²
    total_channels = 340;
    traffic_per_user = 0.025; % Erlang
    h_b = 20; % BS height (m)
    h_m = 1.5; % MS height (m)
    n = 4; % Path loss exponent

    % 1) Cluster Size vs SIR_min (1dB to 30dB)
    plot_cluster_size_vs_sir();
end

function plot_cluster_size_vs_sir()
    % Parameters
    SIR_range = 1:0.1:30; % dB range with 0.1dB resolution
    possible_N = [1, 3, 4, 7, 9, 12, 13, 19, 21, 27]; % Valid cluster sizes (i²+ij+j²)
    n = 4; % Path loss exponent
    
    % Preallocate arrays
    N_omni = zeros(size(SIR_range));
    N_120 = zeros(size(SIR_range));
    N_60 = zeros(size(SIR_range));
    
    % Calculate cluster sizes for each configuration
    for i = 1:length(SIR_range)
        % Omnidirectional (no sectorization)
        N_omni(i) = find_min_cluster_size(SIR_range(i), n, possible_N);
        
        % 120° sectorization (4dB improvement)
        N_120(i) = find_min_cluster_size(SIR_range(i) -4.771212547, n, possible_N);
        
        % 60° sectorization (7dB improvement)
        N_60(i) = find_min_cluster_size(SIR_range(i) - 7.781512504, n, possible_N);
    end
    
    % Create the plot
    figure('Position', [100 100 800 600], 'Color', 'w');
    
    % Plot settings
    p1 = plot(SIR_range, N_omni', 'LineWidth', 2);
    hold on;
    p2 = plot(SIR_range, N_120', 'LineWidth', 2);
    p3 = plot(SIR_range, N_60, 'LineWidth', 2);
    
    % Highlight key SIR thresholds
    %xline(14, 'k:', '14 dB', 'LabelVerticalAlignment', 'bottom', 'LineWidth', 1.5);
    %xline(19, 'k:', '19 dB', 'LabelVerticalAlignment', 'bottom', 'LineWidth', 1.5);
    
    % Formatting
    xlabel('Minimum SIR (dB)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Cluster Size (N)', 'FontSize', 12, 'FontWeight', 'bold');
    title('Cluster Size vs. Minimum SIR for Different Sectorizations', 'FontSize', 14);
    
    % Legend and grid
    legend([p1 p2 p3], {'Omni-directional', '120° Sectorization', '60° Sectorization'}, ...
           'Location', 'northwest', 'FontSize', 10);
    grid on;
    

  
end

function N = find_min_cluster_size(SIR_dB, n, possible_N)
    % Find minimum cluster size N that meets SIR requirement
    % Correct SIR formula for hexagonal cellular systems:
    % SIR = (q^n)/6 where q = D/R = sqrt(3N)
    % In dB: SIR(dB) = 10*log10((sqrt(3*N))^n / 6)
    
    for N = possible_N
        q = sqrt(3*N); % Reuse factor
        SIR_actual = 10*log10(((q-1)^n)/6);
        
        if SIR_actual >= SIR_dB
            return;
        end
    end
    N = possible_N(end); % Use largest possible if none meet requirement
end