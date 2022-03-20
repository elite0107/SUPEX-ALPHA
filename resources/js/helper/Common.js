export default {
    isEmpty: function (value) {
        if (
            value === null ||
            value === undefined ||
            value === "" ||
            (Array.isArray(value) && value.length === 0) ||
            (value instanceof Object && Object.keys(value).length === 0)
        ) {
            return true;
        }
        return false;
    },
};
