# biases_disease_forecasting
Code of the manuscript "Systematic biases in disease forecasting - role of behavior change."

Extended_KF_short_term.m - Runs a sequence of Kalman updates for the disease spread model with short term awareness. In it, it calls sir_dynamics_Euler_integration_short_term.m and sir_dynamics_Euler_backintegration_short_term.m

Extended_KF_long_term.m - Runs a sequence of Kalman updates for the disease spread model with long term awareness. In it, it calls sir_dynamics_Euler_integration.m and sir_dynamics_Euler_backintegration.m

Extended_KF_k_short_term.m - Runs a sequence of Kalman updates for the disease spread model with short term awareness. In it, it calls sir_dynamics_Euler_integration_short_term.m and sir_dynamics_Euler_backintegration_short_term.m

Extended_KF_k_long_term.m - Runs a sequence of Kalman updates for the disease spread model with long term awareness. It calls sir_dynamics_Euler_integration.m and sir_dynamics_Euler_backintegration.m

Monthly_plots_cones.m - Includes instructions to plot Figure 3. Run the script after following the instructions

Figure_4_a_b.m - Includes instructions to plot Figure 4. Run the script after following the instructions to generate the figures

Figure_5.m - Includes instructions to plot Figure 5. Run the script after following the instructions to generate the figures

run_experiments_k_mean.m - generates data for figure S1 and plots the figure. Calls Extended_KF_k multiple times

run_experiments_k_mean_variance.m - Generates Figure S2. 

run_experiments_M.m - Generates Figure S3. 

