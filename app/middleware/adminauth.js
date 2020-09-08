module.exports = (options) => {
  return async function adminauth(ctx, next) {
    const { openId } = ctx.session;
    console.log(openId);
    if (openId) {
      await next();
    } else {
      ctx.body = {
        code: -4,
        data: "",
        msg: "没有登录",
      };
    }
  };
};
