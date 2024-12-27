export function success(req, res, statusCode, message, data = {}) {
    res.status(statusCode).json({
        status: "success",
        message: message,
        data: data
    });
}
export const error = (req, res, status=500, mensaje='') => {
    res.status(status).json({
        error:true,
        status: status,
        body:mensaje
    })
}