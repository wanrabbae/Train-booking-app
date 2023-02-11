@extends('templating.template')

@section('content')
    <div class="page-wrapper">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="page-breadcrumb">
            <div class="row align-items-center">
                <div class="col-6">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 d-flex align-items-center">
                            <li class="breadcrumb-item"><a href="index.html" class="link"><i class="mdi mdi-home-outline fs-4"></i></a></li>
                            <li class="breadcrumb-item active" aria-current="page">Starter Page</li>
                        </ol>
                    </nav>
                    <h1 class="mb-0 fw-bold">{{ $title ?? '' }}</h1>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Container fluid  -->
        <!-- ============================================================== -->
        <div class="container-fluid">
            <!-- ============================================================== -->
            <!-- Start Page Content -->
            <!-- ============================================================== -->
            <div class="container mb-2">
                @if ($errors->any())
                    <div class="alert alert-danger p-2" role="alert">
                        {{ $errors->first() }}
                    </div>
                @endif

                @if (session()->has('success'))
                    <div class="alert alert-success p-2" role="alert">
                        {{ session()->get('success') }}
                    </div>
                @endif
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="container pb-2 d-flex justify-content-end">
                        <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#staticBackdrop">Add</button>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <table id="customer-table" class="display" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Wagon Name</th>
                                        <th>Wagon Type</th>
                                        <th>Seat Num</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="body-customer">
                                    <?php $i = 1; ?>
                                    @foreach ($wagons as $item)
                                        <tr>
                                            <td id="itemid">
                                                {{ $i++ }}
                                            </td>
                                            <td id="item->name">
                                                {{ $item->name }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->type }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->wagon_seat->count() }}
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-success" class="btn btn-primary btn-lg" data-bs-toggle="modal"
                                                    data-bs-target="#staticBackdrop2{{ $item->id }}" id="editCustomer">Edit</button>

                                                {{-- MODAL EDIT --}}
                                                <div class="modal fade" id="staticBackdrop2{{ $item->id }}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                                                    aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h1 class="modal-title fs-2" id="staticBackdropLabel">Edit Station</h1>
                                                                <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form action="/trains/update/{{ $item->id }}" method="post">
                                                                    @csrf
                                                                    <div class="mb-3">
                                                                        <label for="train_name">Train Name</label>
                                                                        <input required type="text" value="{{ $item->train_name }}" name="train_name" id="train_name" class="form-control"
                                                                            placeholder="Enter station name" value="{{ old('train_name') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="eco_seat_num">Economy Seat Num</label>
                                                                        <input required type="number" value="{{ $item->eco_seat_num }}" name="eco_seat_num" id="eco_seat_num" class="form-control"
                                                                            placeholder="Enter eco_seat_num" value="{{ old('eco_seat_num') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="exec_seat_num">Executive Seat Num</label>
                                                                        <input required type="number" value="{{ $item->exec_seat_num }}" name="exec_seat_num" id="exec_seat_num" class="form-control"
                                                                            placeholder="Enter exec_seat_num" value="{{ old('exec_seat_num') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="busines_seat_num">Business Seat Num</label>
                                                                        <input required type="number" value="{{ $item->busines_seat_num }}" name="busines_seat_num" id="busines_seat_num"
                                                                            class="form-control" placeholder="Enter busines_seat_num" value="{{ old('busines_seat_num') }}">
                                                                    </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" id="closeModal" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                <button type="submit" class="btn btn-primary">Save</button>
                                                            </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                |
                                                <a href="/trains/wagon/{{ $item->id }}/passengers" class="btn btn-sm btn-info">Passengers</a>
                                                |
                                                <a class="btn btn-sm btn-danger" href="/trains/delete/{{ $item->id }}" onclick="return confirm('Are you sure ?')">Delete</a>
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End PAge Content -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Right sidebar -->
            <!-- ============================================================== -->
            <!-- .right-sidebar -->
            <!-- ============================================================== -->
            <!-- End Right sidebar -->
            <!-- ============================================================== -->
        </div>

        {{-- MODAL CREATE --}}
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-2" id="staticBackdropLabel">Create New Train</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/trains/add" method="post">
                        @csrf
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="train_name">Train Name</label>
                                <input required type="text" name="train_name" id="train_name" class="form-control" placeholder="Enter station name" value="{{ old('train_name') }}">
                            </div>
                            <div class="mb-3">
                                <label for="eco_seat_num">Economy Seat Num</label>
                                <input required type="number" name="eco_seat_num" id="eco_seat_num" class="form-control" placeholder="Enter eco_seat_num" value="{{ old('eco_seat_num') }}">
                            </div>
                            <div class="mb-3">
                                <label for="exec_seat_num">Executive Seat Num</label>
                                <input required type="number" name="exec_seat_num" id="exec_seat_num" class="form-control" placeholder="Enter exec_seat_num" value="{{ old('exec_seat_num') }}">
                            </div>
                            <div class="mb-3">
                                <label for="busines_seat_num">Business Seat Num</label>
                                <input required type="number" name="busines_seat_num" id="busines_seat_num" class="form-control" placeholder="Enter busines_seat_num"
                                    value="{{ old('busines_seat_num') }}">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- End footer -->
            <!-- ============================================================== -->
        </div>

        <footer class="footer text-center">
            All Rights Reserved by Flexy Admin. Designed and Developed by <a href="https://www.wrappixel.com">WrapPixel</a>.
        </footer>
        <script>
            $('#customer-table').DataTable();
        </script>
    </div>
@endsection
