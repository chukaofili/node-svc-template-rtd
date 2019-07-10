'use strict';

const chai = require('chai');
const expect = chai.expect;

const chaiHttp = require('chai-http');
const app = require('../index');
chai.use(chaiHttp);

describe('test app', () => {
  it('it should return 200 OK', (done) => {
    chai.request(app)
      .get('/')
      .then((res) => {
        expect(res).to.have.status(200);
        done();
      })
      .catch((err) => {
        throw err;
      });
  });
});
