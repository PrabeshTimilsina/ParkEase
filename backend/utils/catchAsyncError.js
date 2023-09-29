module.exports = (tryCatchAsync) => (req, res, next) => {
  Promise.resolve(tryCatchAsync(req, res, next)).catch(next);
};
