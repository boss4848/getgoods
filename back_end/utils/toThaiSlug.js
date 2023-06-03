function toThaiSlug(inputString) {
    let slug = inputString.replace(/\s+/g, '-')
        .replace(/[^\u0E00-\u0E7F\w\-]+/g, '')
        .replace(/\-\-+/g, '-')
        .replace(/^-+/, '')
        .toLowerCase();
    return slug;
}

exports.toThaiSlug = toThaiSlug;