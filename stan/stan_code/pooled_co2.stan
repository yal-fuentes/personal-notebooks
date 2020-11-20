// Pooled model: All groups with common variance
// and common alpha and beta for mean
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
  real alpha; // common alpha
  real beta; // common beta
  real<lower=0> sigma; // common std
}
transformed parameters {
  vector [N] mu;
  mu = alpha + beta * x;
}
model {
  alpha ~ normal(pmualpha, psalpha); // informative prior for alpha
  beta ~ normal(pmubeta, psbeta); // informative prior for beta 
  sigma ~ gamma(2, 1); // weakly informative prior 
  y ~ normal(mu, sigma);
}
generated quantities {
  vector [N] ypred;
  vector [N] log_lik;
  for (i in 1:N)
    ypred[i] = normal_rng (alpha + beta * xpred[i], sigma); // prediction per country
  for (i in 1:N)
    log_lik[i] = normal_lpdf (y[i] | alpha +  beta * xpred[i], sigma); // log likelihood 
}
