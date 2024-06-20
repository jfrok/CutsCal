const config = {
        validationRules: {
            required: [(v) => !!v || 'Required field!'],
            name: [(v) => !!v || 'Required field!', (value) => (value && !(value.length > 100)) || 'Maximum 100 characters'],
            email: [(v) => !!v || 'Email address is not valid!', (v) => /.+@.+\..+/.test(v) || 'Invalid email address!'],
            phonenumber: [(v) => !!v || 'Phone number is not valid!', (v) => /^[+]?[\s./0-9]*[(]?[0-9]{1,4}[)]?[-\s./0-9]*$/g.test(v) || 'Invalid phone number!'],

        },
    frame:{
            urls:{
                live: 'https://jhdevelopers.com/',
                local: 'http://localhost:8080/',
            }
    }
};

export default config;
