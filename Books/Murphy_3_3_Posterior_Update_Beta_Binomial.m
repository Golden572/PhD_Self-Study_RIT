clc; clear all; close all;

% Initial prior
a_prior = input('Enter the initial prior hyperparameter a: '); a_prior_initial = a_prior;
b_prior = input('Enter the initial prior hyperparameter b: '); b_prior_initial = b_prior;
N1 = input('Enter the number of heads (successes): ');
N0 = input('Enter the number of tails (failures): ');
M = input('Enter number of updates (M): ');

% Range for theta
theta = linspace(0, 1, 500);

% Initial Prior & Likelihood
prior_initial = betapdf(theta, a_prior_initial, b_prior_initial);
likelihood_initial = betapdf(theta, N1+1, N0+1);

% Loop through M updates
for i = 1:M

    % Posterior update
    a_post = a_prior + N1;
    b_post = b_prior + N0;

    % Use this posterior as new prior for next iteration
    a_prior = a_post;
    b_prior = b_post;
end

% Final posterior
posterior = betapdf(theta, a_post, b_post);

% Plot final posterior
figure;
plot(theta, prior_initial, 'r-', 'LineWidth', 1.5); hold on;
plot(theta, likelihood_initial, 'k--', 'LineWidth', 1.5);
plot(theta, posterior, 'b-.', 'LineWidth', 1.5); 
xlabel('\theta'); ylabel('Density');
title(sprintf('Final Posterior Beta(%d,%d)', a_post, b_post));
legend(sprintf('Posterior Beta(%d,%d)', a_post, b_post));
legend(sprintf('Initial Prior Beta(%d,%d)', a_prior_initial, b_prior_initial), ...
       sprintf('Initial Likelihood Bino(%d,%d)', N1, N0), ...
       sprintf('Final Posterior Beta(%d,%d)', a_post, b_post));
grid on;

