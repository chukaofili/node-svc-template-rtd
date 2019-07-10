'use strict';

const chai = require('chai');
const expect = chai.expect;

describe('sanity check', () => {
    it('true is truthy', (done) => {
        expect(true).to.be.true;
        done();
    });
});
