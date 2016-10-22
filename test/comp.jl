using TensorFlow
using Base.Test

sess = TensorFlow.Session(TensorFlow.Graph())
a_raw = collect(1:5)
b_raw = collect(6:10)
a = TensorFlow.constant(a_raw)
b = TensorFlow.constant(b_raw)

@test (a_raw .== b_raw) == run(sess, TensorFlow.equal(a,b))
@test (a_raw .!= b_raw) == run(sess, TensorFlow.not_equal(a,b))
@test (a_raw .< b_raw) == run(sess, TensorFlow.less(a,b))
@test (a_raw .<= b_raw) == run(sess, TensorFlow.less_equal(a,b))
@test (a_raw .> b_raw) == run(sess, TensorFlow.greater(a,b))
@test (a_raw .>= b_raw) == run(sess, TensorFlow.greater_equal(a,b))

cond = [true; false; true; true; false]
cond_tf = TensorFlow.constant(cond)
result = run(sess, TensorFlow.select(cond_tf, a, b))
@test [1; 7; 3; 4; 10] == result

result = run(sess, ifelse(cond_tf))
@test all(find(cond)-1 .== result)
