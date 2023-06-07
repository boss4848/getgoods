class APIFeatures {
    constructor(query, queryString) {
        this.query = query;
        this.queryString = queryString;
    }
    filter() {
        //Querying
        const queryObj = { ...this.queryString };
        const excludedFields = ['page', 'sort', 'limit', 'fields'];
        excludedFields.forEach(el => delete queryObj[el]);

        let queryStr = JSON.stringify(queryObj);
        //Add $ to the query operators
        // /?price[gte]=1000&price[lte]=2000
        queryStr = queryStr.replace(/\b(gte|gt|lte|lt)\b/g, match => `$${match}`);

        this.query = this.query.find(JSON.parse(queryStr));
        return this;
    }
    sort() {
        //Sorting
        if (this.queryString.sort) {
            const sortBy = this.queryString.sort.split(',').join(' ');
            this.query = this.query.sort(sortBy);
        } else {
            this.query = this.query.sort('-createdAt');
        }
        return this;
    }
    limitFields() {
        //Field limiting
        // /?fields=name,price
        if (this.queryString.fields) {
            const fields = this.queryString.fields.split(',').join(' ');
            this.query = this.query.select(fields);
        } else {
            this.query = this.query.select('-__v');
        }
        return this;
    }
    paginate() {
        //Pagination
        // /?page=2&limit=10
        const page = this.queryString.page * 1 || 1; //convert string to number
        const limit = this.queryString.limit * 1 || 100;
        const skip = (page - 1) * limit;
        //page=2&limit=10, 1-10, page 1, 11-20, page 2, 21-30, page 3
        this.query = this.query.skip(skip).limit(limit);

        return this;
    }
}
module.exports = APIFeatures;