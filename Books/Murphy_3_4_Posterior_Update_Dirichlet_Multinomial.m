close all;

% ===== User Inputs =====
K = input('Enter number of classes (e.g., sides of a dice): ');
alpha_prior = input('Enter the K-dimensional vector of Dirichlet prior (e.g., [1 1 1 1 1 1]): ');
M = input('Enter number of updates (M): ');

% ===== Check input dimensions =====
if length(alpha_prior) ~= K
    error('Length of prior vector must match number of classes (K)');
end

% Save initial prior for plotting
alpha_prior_initial = alpha_prior;

% ===== Get counts per class =====
Nk = zeros(1, K);
for k = 1:K
    Nk(k) = input(sprintf('Enter number of observations for class %d: ', k));
end

% ===== Simulate M updates =====
for m = 1:M
    alpha_prior = alpha_prior + Nk;
end

% ===== Final posterior =====
alpha_post = alpha_prior;

% ===== Plot prior and posterior marginals =====
theta = linspace(0, 1, 500);
figure;
for k = 1:K
    subplot(ceil(K/2), 2, k);
    
    % Initial marginal: Beta(alpha_k, sum(alpha_-k))
    a_k_prior = alpha_prior_initial(k);
    a_rest_prior = sum(alpha_prior_initial) - a_k_prior;
    prior_beta = betapdf(theta, a_k_prior, a_rest_prior);
    
    % Posterior marginal
    a_k_post = alpha_post(k);
    a_rest_post = sum(alpha_post) - a_k_post;
    post_beta = betapdf(theta, a_k_post, a_rest_post);
    
    % Plot both
    plot(theta, prior_beta, 'r--', 'LineWidth', 1.5); hold on;
    plot(theta, post_beta, 'b-', 'LineWidth', 2);
    
    xlabel(sprintf('\\theta_{%d}', k)); ylabel('Density');
    title(sprintf('Class %d: Prior vs Posterior', k));
    legend(sprintf('Prior Beta(%d, %d)', a_k_prior, a_rest_prior), ...
           sprintf('Posterior Beta(%d, %d)', a_k_post, a_rest_post));
    grid on;
end

sgtitle('Dirichlet-Multinomial Marginals: Prior vs Posterior');
