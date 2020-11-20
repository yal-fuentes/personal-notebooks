// Hierarchical model: Common variance and 
// hierarchical prior for alpha and beta
data {
  int<lower=0> N; // number of data points
  int<lower=0> K; // number of data groups
  int<lower=1, upper=K> z[N]; // group indicator
  vector [N] x; // observation log(income)
  vector [N] y; // observation log(co2)
  vector [N] xpred; // prediction income
  real pmualpha; // prior mean for alpha
  real psalpha; // prior mean for alpha
  real pmubeta; // prior mean for alpha
  real psbeta; // prior mean for alpha
}
parameters {
  real alpha0; // prior alpha
  real <lower=0> salpha0; // prior alpha std
  real beta0; // prior beta
  real <lower=0> sbeta0; // prior beta std
  vector[K] alpha; // group alpha
  vector[K] beta; // group alpha
  real<lower=0> sigma; // common std
}
transformed parameters {
  vector [N] mu;
  for (i in 1:N)
    mu[i] = alpha[z[i]] + beta[z[i]] * x[i]; // hierarchical model
}
model {
  alpha0 ~ normal(pmualpha, psalpha); // informative prior for population alpha
  salpha0 ~ gamma(2, 1); // weakly informative prior 
  beta ~ normal(pmubeta, psbeta); // informative prior for population beta 
  sbeta0 ~ gamma(2, 1); // weakly informative prior 
  alpha ~ normal(alpha0, salpha0); // alpha continent prior with unkown parameters
  beta ~ normal(beta0, sbeta0); // beta continent prior with unkown parameters
  sigma ~ gamma(2, 1); // weakly informative prior 
  y ~ normal(mu, sigma);
}
generated quantities {
  vector [N] ypred;
  vector [N] log_lik;
  for (i in 1:N)
    ypred[i] = normal_rng (alpha[z[i]] + beta[z[i]] * xpred[i], sigma); // prediction per country
  for (i in 1:N)
    log_lik[i] = normal_lpdf (y[i] | alpha[z[i]] +  beta[z[i]] * xpred[i], sigma); // log likelihood 
}
